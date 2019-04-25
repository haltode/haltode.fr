The WebGraph Framework I: Compression Techniques
================================================

Paolo Boldi, Sebastiano Vigna (2004):
http://www.web.ethz.ch/CDstore/www2004/docs/1p595.pdf

WebGraph Framework: http://webgraph.di.unimi.it/

Features of the links of a web graph:

- locality: most links contained in a page have a navigational nature (ie: they
  lead the user to some other pages within the same host)
- similarity: when sorted, URL tend to have many common successors (because of
  the many navigational links)

The compression format
----------------------

- **gaps**: store the offset from previous node instead of the nods ID
- **reference**: instead of representing the adjacency list $S(x)$ directly, we
  can code it as a "modified" version of $S(y)$ (called the reference list)
    - copy list: elements from $S(y)$ that is in $S(x)$
    - extra nodes list
- **differential**: differences with $S(y)$ are recorded as copy blocks instead
  of copy list
- **intervals**: instead of $x, x+1, \\ldots, x+n$, store only $[x;x+n]$
  (exploit consecutivity)

The final WebGraph compression format uses a mix of methods above.

Random access
-------------

Reference chains: to access random contents of the graph, we need to decompress
all the information from the compression format and follow reference links. This
might slow down the access process (worst-case: decompress all the info) so we
need to put a limit on the lengths of the reference chains.

We also need to store an offset array of size $N$ if we want to access the graph
in random order instead of sequentially.

Implementation details
----------------------

Lazy iterator: the data is filtered as you request it (it doesn't go through all
the list immediately).

Related work
------------

- Connectivity Server (URL sorting)
- LINK Database (reference compression)

Layered Label Propagation
=========================

Paolo Boldi, Marco Rosa, Massimo Santini (2011): https://arxiv.org/abs/1011.5425

Most compression algorithms exploit properties such as similarity, locality,
etc. hence the way nodes are ordered influence a lot the result.

- extrinsic: uses external data besides the graph itself (eg: URL)
- intrinsic: only uses the graph itself -> question: is there any intrinsic
  order of the nodes with good compression ratio?

Problem definition
------------------

- $A$ graph compression algorithm
- $G$ input graph
- $P_A(G, \\pi)$ numbers of bits/link needed by $A$ to store $G$ under $\\pi$
  node numbering

Goal: find a node numbering $\\pi$ minimising $P_A(G, \\pi)$.

Such optimization problem is NP-Hard, meaning we can only expect heuristics.

Empirical insight: it is important for high compression ratio to use an ordering
of vertex IDs such that the vertices from the same host are close to one
another.

- Define a measure of how well a node numbering $\\pi$ respects the partitioning
  $H$ due to hosts => $HT$
- Define a measure to compare two partitions $H1$ and $H2$ => $VI$

Note: **coordinate-free** algorithm means it achieves almost the same compression
performance starting from any initial ordering.

Label Propagation Algorithms (LPA)
----------------------------------

The algorithm executes in rounds, every node has a label corresponding to the
cluster it belongs to (at the beginning every node has a different label).

At each round, each node updates its label according to some rule. The algorithm
terminates as soon as no more updates.

Layered Label Propagation (LLP)
-------------------------------

LLP is built on APM (Absolute Potts Model) which is built on LPA => LLP
iteratively executes APM with various $\\gamma$ values.

Implementation detail: the node order during rounds is random, hence there is
no obstacle in updating several nodes in parallel.

Note: most of the time is spent on sampling values of $\\gamma$ to produce base
clusterings => you can reduce the numbers of $\\gamma$ values to speed up the
process.

Results
-------

- LLP + BV is the best compressed data structure available at the time
- LLP is extremely robust with respect to the initial ordering of the nodes (ie:
  coordinate-free)

Compressing Graphs and Indexes with Recursive Graph Bisection
=============================================================

Laxman Dhulipala, Igor Kabiljo, Brian Karrer, Giuseppe Ottaviano, Sergey
Pupyrev, Alon Shalita (2016): https://arxiv.org/abs/1602.08820

Previous work on compression techniques:

- **structural approches**: find and merge repeating graph patterns (eg: clique)
- **graph reordering**: find suitable order of graph vertices, encode adjacency
  data with some integer code/reordering

Inverted index (also known as postings file): database index storing a mapping
from content (eg: word, content) to its location (eg: table, document). Allows
fast full-text searches (use case: search engine indexing algorithm).

Problem definition
------------------

Graph reordering is a combinational optimization problem with a goal to find a
layout (= order = numbering = arrangement) of the input graph to optimize a cost
function: :math:`\pi\colon\mathbb V\to\mathbb {1 \ldots n}`

Empiric insight: it is desirable that similar vertices are close in $\\pi$.

**Minimum linear arrangement** (MLA): minimize
:math:`\displaystyle\sum_{(u,v)\in E} |\pi(u) - \pi(v)|`

**Minimum logarithmic arrangement** (MLogA): minimize
:math:`\displaystyle\sum_{(u,v)\in E} \log |\pi(u) - \pi(v)|`

In practice, adjacency list is stored using an encoding, so the gaps induced by
consecutive neighbors are important for compression hence the MLogGapA problem.

**Minimum logarithmic gap arrangement** (MLogGapA): minimize
:math:`\displaystyle\sum_{u\in V} f_{\pi}(u, out(u))` where :math:`f_{\pi}(u,
out(u)) = \displaystyle\sum_{i=1}^{k} \log | \pi(u_{i+1}) - \pi(u_{i}) |`

MLA and MLogA were known to be NP-Hard, this paper proves that MLogGapA is also
NP-Hard.

Model for graph/index compression
---------------------------------

- **Query vertex**: word in inverted index
- **Data vertex**: document containing the word

**Bipartite minimum logarithmic arrangement** (BiMLogA): generalize MLogA and
MLogGapA, minimize :math:`\displaystyle\sum_{q \in Q}\sum_{i=1}^{k} \log
(\pi(u_{i+1}) - \pi(u_{i}))` where $k$ is the degree, $Q$ query vertices, $D$
data vertices and the graph :math:`G = (Q \cup D, E)`.

Note: BiMLogA and MLogGapA differs since the latter does not distinguish between
query and data vertices.

.. figure:: /img/gsoc2019/graph_bisection_input_model.png
   :alt: Graph input model

    Graph input model


Algorithm
---------

Graph bisection: initially split $D$ into two sets of same size $V_1$ and $V_2$,
and compute a cost of how "compression-friendly" the partition is. Next, swap
vertices in $V_1$ and $V_2$ to improve the cost (=> compute the "move gain").

Notes:

- Here the cost function estimates the number of bits needed to represent $G$
  using delta-encoding.
- The initialization of sets $V_1$ and $V_2$ can influence the results (multiple
  techniques used: Random, Natural, BFS, Minhash)

Main algorithm steps:

1. Find graph bisection $G_1$ and $G_2$ of $G$
2. Recursively find linear arrangements for $G_1$ and $G_2$
3. Concatenate the resulting order

Time complexity: :math:`O(m\log n + n\log^2 n)`

In the implementation, the algorithm can be parallelized/distributed:

- The two recursive calls are independent
- Graph bisection steps compute independent values for every vertex

Conclusion
----------

- Best algorithm so far (compression ratios and timings)
- Highly scalable (tested on graph with billions of nodes/edges)

Compressing Inverted Indexes with Recursive Graph Bisection: a reproducibility study
====================================================================================

Joel Mackenzie, Antonio Mallia, Matthias Petri, J. Shane Culpepper, and Torsten
Suel (2019)

Note: focuses on inverted indexes more than graph

Goals:

- Validate and check experimental results of the algorithm developed in the
  original paper
- C++17 open-source implementation
    - https://github.com/pisa-engine/ecir19-bisection/
    - https://github.com/pisa-engine/pisa

Multiple ordering techniques:

- **Random**
- **Natural**: natural ordering such as URLs for webgraphs
- **Minhash** (or **shingle**): heuristic that approximates the `Jaccard Index
  <https://en.wikipedia.org/wiki/Jaccard_index>`_ (measures similarity between
  two sets) in order to cluster similar documents together.

BP ordering runs in :math:`O(m\log n + n\log^2 n)` and yield excellent
arrangements in practice by approximating the solution to the BiMLogA problem.

*implementation/pseudo-code details*

*optimization details*

Reproducibility notes:

- Valid algorithm and results from original paper
- From empirical results, recommended to use Natural or Minhash initial ordering
  with $MaxIter = 20$ (lower $MaxIter$ if run time is more critical than
  compression ratio)
- The initial ordering of $V_1$ and $V_2$ has a very moderate impact on the
  efficacy of the bisection algorithm
- :math:`MaxDepth = \log n - 5`
