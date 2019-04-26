Pre-application period
----------------------

The goal was to become more familiar with SWH infrastructure, code review and
the community. I joined the IRC channel #swh-devel and the `mailing list
<https://sympa.inria.fr/sympa/info/swh-devel>`_ and started working on getting
the SWH development setup running. I focused on the "Easy hacks" tasks (`D1226
<https://forge.softwareheritage.org/D1226>`_, `D1235
<https://forge.softwareheritage.org/D1235>`_) and documentation fixes (`D1217
<https://forge.softwareheritage.org/D1217>`_, `D1242
<https://forge.softwareheritage.org/D1242>`_) at first, before studying more in
depth the subject I chose: `Graph compression on the development history of
software
<https://wiki.softwareheritage.org/wiki/Graph_compression_on_the_development_history_of_software_(internship)>`_.
This allowed me to experiment for a bit with the SWH codebase, run tests
environment, solve some issues, and talk with SWH staffers!

I contacted the mentor for the subject early, and sent my resume. He quickly got
back to me, and gave me papers to read on graph compression techniques:

- `The WebGraph Framework I: Compression Techniques
  <http://www.web.ethz.ch/CDstore/www2004/docs/1p595.pdf>`_
- `Layered Label Propagation: A MultiResolution Coordinate-Free Ordering for
  Compressing Social Networks <https://arxiv.org/pdf/1011.5425>`_

They already had some early results, thanks to Boldi & Vigna (the authors of the
WebGraph framework/paper) and I tried replicating it on my own laptop.
Unfortunately, I only have 8GB of RAM so running Java programs to compress big
files quickly gets OOM killed.

My mentor told me he can maybe give me access to a VM so I could run my
experiments, in the meantime I automated the setup process and testing using
Docker and a bash script to retrieve datasets and compress them using WebGraph.

[[secret="Dockerfile"]]

.. code:: docker

    FROM maven:3.6.0-jdk-8
    WORKDIR /app

    # Download webgraph binary
    RUN curl -O http://webgraph.di.unimi.it/webgraph-3.6.1-bin.tar.gz
    RUN tar xvfz webgraph-3.6.1-bin.tar.gz
    RUN cp webgraph-3.6.1/webgraph-3.6.1.jar .

    # Download webgraph dependencies
    RUN curl -O http://webgraph.di.unimi.it/webgraph-deps.tar.gz
    RUN tar xvfz webgraph-deps.tar.gz

    # Download missing LAW dependency
    RUN curl -O http://law.di.unimi.it/software/download/law-2.5-bin.tar.gz
    RUN tar xvfz law-2.5-bin.tar.gz
    RUN cp law-2.5/law-2.5.jar .

    WORKDIR /graph
    COPY compress_graph .

[[/secret]]

[[secret="compress_graph"]]

.. code:: bash

    #!/bin/bash

    DATASET=release_to_obj

    # Download the edge list
    curl -O https://annex.softwareheritage.org/public/dataset/swh-graph-2019-01-28/edges/$DATASET.csv.gz
    # Uncompress the edge list
    gunzip $DATASET.csv.gz
    # Compute the node list
    tr ' ' '\n' <$DATASET.csv | sort -u >$DATASET.nodes

    # Build a function (MPH) that maps node names to node numbers in lexicographic order (output: $DATASET.mph)
    java -cp /app/'*' it.unimi.dsi.sux4j.mph.GOVMinimalPerfectHashFunction $DATASET.mph /data/$DATASET.nodes

    # Build the graph in BVGraph format (output: $DATASET.*)
    java -cp /app/'*' it.unimi.dsi.webgraph.ScatteredArcsASCIIGraph -f $DATASET.mph $DATASET </data/$DATASET.csv

    # Create a symmetrized version of the graph (output: $DATASET-s.*)
    java -cp /app/'*' it.unimi.dsi.webgraph.Transform symmetrizeOffline $DATASET $DATASET-s

    # Find a better permutation through Layered LPA (output: $DATASET.llpa)
    java -cp /app/'*' it.unimi.dsi.law.graph.LayeredLabelPropagation $DATASET-s $DATASET.llpa

    # Permute the graph accordingly (output: $DATASET-compr.*)
    java -cp /app/'*' it.unimi.dsi.webgraph.Transform mapOffline $DATASET $DATASET-compr $DATASET.llpa

    # Compute graph statistics (output: $DATASET.stats)
    java -cp /app/'*' it.unimi.dsi.webgraph.Stats -s $DATASET

    # Clean up the current directory
    mkdir $DATASET
    mv $DATASET.* $DATASET
    mv $DATASET-s.* $DATASET
    mv $DATASET-compr.* $DATASET

[[/secret]]

I also took the time to dive more into research papers and SWH infrastructure:

- `Software Heritage: Why and How to Preserve Software Source Code
  <https://hal.archives-ouvertes.fr/hal-01590958/document>`_
- The Software Heritage Graph Dataset: Public software development under one
  roof
- https://docs.softwareheritage.org/devel/
- https://docs.softwareheritage.org/devel/glossary.html
- https://wiki.softwareheritage.org/wiki/Special:AllPages
- `Smaller and Faster: Parallel Processing of Compressed Graphs with Ligra+
  <https://people.csail.mit.edu/jshun/ligra+.pdf>`_
- `Memory-Optimized Distributed Graph Processing through Novel Compression
  Techniques
  <http://www2.aueb.gr/users/katia/publications/LPDcikm2016-preprint.pdf>`_
- `ZipG: A Memory-efficient Graph Store for Interactive Queries
  <http://www.cs.cornell.edu/~ragarwal/pubs/zipg.pdf>`_
- An effective graph summarization and compression technique for a large-scaled
  grap
- `Pregel: A System for Large-Scale Graph Processing
  <https://kowshik.github.io/JPregel/pregel_paper.pdf>`_
- `Graph Summarization Methods and Applications: A Survey
  <https://arxiv.org/pdf/1612.04883.pdf>`_
- `The Link Database: fast access to graphs of the Web
  <http://www.textfiles.com/bitsavers/pdf/dec/tech_reports/SRC-RR-175.pdf>`_
- `Graph Compression by BFS <https://www.mdpi.com/1999-4893/2/3/1031/pdf>`_

A few days before the official application period, I begin writing mine to get
early feedbacks once the deadline hits. Here is the final pdf: `proposal.pdf
<https://haltode.fr/upload/proposal.pdf>`_.

Application period (part 1)
---------------------------

My mentor gave me access to a first VM with 140GB of RAM and 72vCPUs so I could
do some early experiments. But I quickly got limited by the disk space (first
time I have more RAM than disk space :D), so they gave me access to another VM.
A **beefy** one: 2TB RAM and 128vCPUs with 1TB of disk storage (for 2 weeks)!

In the same time, they heard about a new reference paper on the graph
compression problem: `Compressing Graphs and Indexes with Recursive Graph
Bisection <https://arxiv.org/pdf/1602.08820.pdf>`_. I went through it quickly
but from their paper: "we do not release the datasets and our source code due to
corporate restrictions". Couldn't find an open source implementation, I
contacted the author to have insights on such implementation but didn't get any
response.

Back to the WebGraph framework, I tried using the -big version (64bit) since
some parts of the DAG contain billions of nodes/edges, but I ran into a runtime
exception. To get some results I used the 32bit version to see if I still had
this exception. The process ran fine but it was **really** slow, and as I
contacted the authors of the WebGraph framework they pointed out a useless
redirection that was intensely slowing down the process (because of swapping).

It's time to gather some data now!
