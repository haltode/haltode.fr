Students selection period (part 2)
----------------------------------

Ligra+
~~~~~~

As for the graph bisection algorithm, I had to write a conversion script (which
is very similar to the one I already wrote):

[[secret="swh_to_ligra.cpp"]]

.. code:: cpp

    #include <algorithm>
    #include <cassert>
    #include <fstream>
    #include <iostream>
    #include <string>
    #include <unordered_map>
    #include <vector>

    struct Dataset
    {
        std::string name;
        size_t nb_nodes;
        size_t nb_edges;
    };

    const std::vector<Dataset> datasets = {
        {"release_to_obj", 16222788, 9907464},
        {"origin_to_snapshot", 112564374, 194970670},
        {"dir_to_rev", 35399184, 481829426},
        {"snapshot_to_obj", 170999796, 831089515},
        {"rev_to_rev", 1117498391, 1165813689},
        {"rev_to_dir", 2047888941, 1125083793}
    };

    void convert_dataset(
        std::string dataset_name, std::string graph_dir, std::string output_dir)
    {
        auto dataset =
            std::find_if(datasets.begin(), datasets.end(),
                [&dataset_name]
                (const Dataset &d) -> bool { return d.name == dataset_name; });
        if (dataset == datasets.end())
        {
            std::cout << "Could not find dataset: " << dataset_name << "\n";
            return;
        }

        std::unordered_map<std::string, uint32_t> node_ids;
        node_ids.reserve(dataset->nb_nodes);

        // Read graph nodes
        {
            std::ifstream graph (graph_dir + dataset->name + ".nodes");
            std::string node;
            size_t node_cnt = 0;
            while (std::getline(graph, node))
            {
                node_ids[node] = node_cnt;
                node_cnt++;
            }

            std::cout << "Read " << node_cnt << " nodes.\n";
            assert(node_cnt == dataset->nb_nodes);
        }

        std::vector<std::vector<int>> edges(dataset->nb_nodes);

        {
            std::ifstream graph (graph_dir + dataset->name + ".edges");
            std::string node1, node2;
            size_t edge_cnt = 0;
            while ( std::getline(graph, node1, ' ') &&
                    std::getline(graph, node2))
            {
                edge_cnt++;
                uint32_t node1_id = node_ids[node1];
                uint32_t node2_id = node_ids[node2];
                edges[node1_id].emplace_back(node2_id);
            }

            std::cout << "Read " << edge_cnt << " edges.\n";
            assert(edge_cnt == dataset->nb_edges);
        }

        std::string file_path = output_dir + dataset->name + ".adj_graph";
        std::ofstream ligra_fmt (file_path, std::ios::out | std::ios::binary);

        ligra_fmt << "AdjacencyGraph\n";
        ligra_fmt << dataset->nb_nodes << '\n';
        ligra_fmt << dataset->nb_edges << '\n';

        long long sum_degree = 0;
        for (uint32_t node_id = 0; node_id < dataset->nb_nodes; node_id++)
        {
            ligra_fmt << sum_degree << '\n';
            sum_degree += edges[node_id].size();
        }

        for (uint32_t node_id = 0; node_id < dataset->nb_nodes; node_id++)
            for (auto edge : edges[node_id])
                ligra_fmt << edge << '\n';
    }

    int main(int argc, char *argv[])
    {
        if (argc != 4)
        {
            std::cout << "Usage: swh_to_ligra dataset_name graph_dir output_dir\n";
            return 0;
        }

        std::string dataset_name = argv[1];
        std::string graph_dir = argv[2];
        if (graph_dir.back() != '/')
            graph_dir += '/';
        std::string output_dir = argv[3];
        if (output_dir.back() != '/')
            output_dir += '/';

        convert_dataset(dataset_name, graph_dir, output_dir);

        return 0;
    }

[[/secret]]

I correctly compressed our smallest datasets (``release_to_obj``,
``origin_to_snapshot`` and ``dir_to_rev``), however when trying to apply the
same method to a bigger dataset (eg: ``snapshot_to_obj``) I got a SIGSEGV.

I wrote the authors of the paper an email for two reasons:

- Better understand why this SIGSEGV happens (maybe similar problem as the graph
  bisection memory consumption).
- Have some insights on how this Ligra+ compression algorithm would behave on
  very sparse graphs.

I didn't get any reply so I moved on, and we decided to stick with WebGraph
anyway.

WebGraph
~~~~~~~~

Here is the git repo my mentor created for the compression project:
https://forge.softwareheritage.org/source/graph-compression/

LLP does not scale on our graph, the ``rev_to_dir`` with 2B nodes and 1B edges
was already quite a lot for the LLP, so we decided to use the BFS re-ordering as
this should land quite similar result because of our graph topology, while
taking way less time (on ``rev_to_dir`` LLP took 53h compared to 30min for BFS).

We needed to port some functions of WebGraph to support 64-bit version (since
our graph have more than $2^{31}$ nodes and edges). I sent multiple patches to
Sebastiano and Paolo:

- A 64-bit version of the BFS traversal on a compressed graph.
- A ``--zipped`` flag enabling to read gzip files as input.

REST API
~~~~~~~~

On the server side, I decided to go with Java to easily work with the WebGraph
framework. I was totally new to the language and ecosystem so learning the
language and how to work with it was my first priority. On the client side, I
chose Python since almost all of the Software Heritage infrastructure is written
in Python, and they already implemented a class to deal with such API.

The first step was to enable REST API communication between the Java server and
the Python client. I initially tried `Spark <http://sparkjava.com/>`_ as the web
framework for Java but moved to `Javalin <https://javalin.io/>`_ because of a
problem with HTTP 1.1 chunked transfer encoding (on the Python side). The client
used the already implemented ``swh.core.SWHRemoteAPI``, not much to do more.

Loading the compressed graph and working with WebGraph was the next logical
step, before implementing actual graph operations.

Community Bonding
-----------------

On May 6th, I got officially accepted to work with Software Heritage as my first
Google Summer of Code! \\o/

I had a call with my mentors (a co-mentor joined in) to discuss about:

- GSoC details: schedule for a weekly call with mentors, weekly recap on the
  SWH mailing list every Friday
- Recap of what has been done so far (for the new co-mentor)
- Future goals
    - Define graph operations and graph structure (compressed as a whole or
      individual datasets, dynamic or static, etc.)
    - Lay out REST API routes
    - Compress the **very** large datasets (``dir_to_{dir,file}``)

WebGraph
~~~~~~~~

Both my mentors got to meet Sebastiano IRL in Paris in a conference about his
work! He also gave us access to a VM they use for experiments with 1TB of RAM
and 40 CPUs. This enabled us to start compression on bigger datasets, but first
we needed to create the .nodes files (which took some time):

.. code:: bash

    zcat $dataset.edges.gz | tr ' ' '\n' |
    sort -u --parallel $nb_threads -S100g -T tmp |
    pigz -p $nb_threads -c > $dataset.nodes.gz

Weekly reports
~~~~~~~~~~~~~~

From this point, I started to write weekly reports, here are the ones for May:

- `Week 2019/19 <https://sympa.inria.fr/sympa/arc/swh-devel/2019-05/msg00000.html>`_
- `Week 2019/20 <https://sympa.inria.fr/sympa/arc/swh-devel/2019-05/msg00002.html>`_
- `Week 2019/21 <https://sympa.inria.fr/sympa/arc/swh-devel/2019-05/msg00005.html>`_
- `Week 2019/22 <https://sympa.inria.fr/sympa/arc/swh-devel/2019-05/msg00015.html>`_
