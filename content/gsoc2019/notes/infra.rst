- https://docs.softwareheritage.org/devel/
- https://docs.softwareheritage.org/devel/glossary.html

Graph archive:

- **file content node** (≈ 200 TB, individually compressed files)
    - stored as a key-value object storage that uses as keys the intrinsic node
      identifiers of the Merkle DAG
    - allows easy horizontal scaling
- **rest of the graph** (≈ 5 TB, .gz files)
    - stored in a relational database management system (RDBMS): one table per
      type of node (directories, revisions, snapshots, etc.)
    - each table uses as primary key the intrinsic node identifier
    - no particular reason to store this graph in a RDBMS but graph db tech are
      not ready for a graph with this size and kind

RDBMS specific:

- master/slave replication
    - enables data from one master server to be copied to slaves servers
    - used to improve recovery guarantees and performance
        - load balancing: all writes updates happen on master server, but read
          operations can take place in any slave server
- point-in-time recovery
- prevent hash collisions by using multiple checksums algorithms (``sha1``,
  ``sha256``, ``sha1_git``, ``blake2s256``)

Archiver
========

https://docs.softwareheritage.org/devel/swh-archiver/archiver-blueprint.html

Goal: keeps track of how many copies of a given file content exist and where
each of them is.

- enforce retention policies
    - "each file content must exist in at least 3 copies"
    - periodically swipe all objects to check adherence, and makes copies if
      necessary
- heal object corruption (due to storage media decay)
    - periodically swipe all copies of objects and verify checksums (and use
      copies to heal objects if data corruption is found)

Characteristics
---------------

- append-only archival
- peer-to-peer topology: every storage can be used as a source or a destination
- asynchronous archival: if new objects are added during archival run (making
  copies of existing objects), these new objects will only be copied in future
  archival run
- integrity at archival time: before adding new objects, verify if possible to
  decompress and compute checksums
- persistent archival status:
    - locations={master, slave_1, ..., slave_n}, each pair of <obj, dst> has:
        - status: missing, ongoing, present, corrupted
        - mtime: timestamp of last status change

Implementation
--------------

- archiver director
    - periodically runs via cron
    - group objects in need of archival into batches and spawn archive worker
      for each batch
- archiver worker
    - executed on demand (celery worker) to archive a set of objects
    - compute map: (source, destination) -> contents
    - launch copier for each transfer in the batch
- archiver copier
    - executed on demand by archiver workers to transfer file batches from a
      given source to a given destination
    - the copying process ensures that concurrent transfer of the same file by
      multiple copier do not result in corrupted files (atomic operation + file
      granularity)

Indexer
=======

https://docs.softwareheritage.org/devel/swh-indexer/metadata-workflow.html

Goal: extract information from multiple SWH objects:
    - content: mimetype, ctags, language, fossology-license, metadata
    - revision: metadata

The indexer stores these info into a db (expected to be called swh-indexer-dev)

Intrinsic metadata
------------------

Examples of supported intrinsic metadata: codemeta.json, pom.xml, package.json,
PGK-INFO, .gemspec

These metadata are translated using `CodeMeta <https://codemeta.github.io/>`_'s
`crosswalk table <https://codemeta.github.io/crosswalk/>`_

Journal
=======

Goal: logs changes to the archive

Publish-subscribe support using Apache Kafka.

Listers
=======

https://docs.softwareheritage.org/devel/swh-lister/tutorial.html

Goal: enumerate the software origins available at a source code distribution
place.

Current supported listers: bitbucket, debian, github, gitlab, npm, pypi

A lister follow these steps:

- Network request to a service endpoint
- Convert the response to a canonical format
- Setup work queue to fetch/ingest the repositories

Loaders
=======

Goal: read and import/update a source code origin in the SWH archive

Current supported loaders: debian, dir, git, mercurial, pypi, svn, tar

Model
=====

Goal: implementation of Merkle DAG to store artifacts. Defines persistent
identifier (PID).

- ``hashutil.py``: defines a ``MultiHash`` class in charge to compute all swh
  hashes (supports ``sha1``, ``sha256``, ``sha1_git``, ``blake2s256``)
- intrinsic identifier: the ``sha1``, ``sha1_git`` and ``sha256`` checksums of
  its data.

Data model
----------

- https://docs.softwareheritage.org/devel/swh-model/data-model.html

- contents (aka blobs)
- directories
- revisions (aka commits)
- releases (aka tags)

Crawling-related information:

- origins: (type, url) where type is git, svn, ...
- snapshots (aka branches, stable/dev packages, ...)
- visits: link origins with snapshots (every time an origin is consulted, new
  visit object is created with corresponding snapshot and timestamp)

SWH archive is a single Merkle Direct Acyclic Graph. Inherited properties from
this:

- data deduplication
- SWH data unified as a whole

Persistent identifier (PID)
---------------------------

- https://docs.softwareheritage.org/devel/swh-model/persistent-identifiers.html
- https://hal.archives-ouvertes.fr/hal-01865790v4

Every SWH object can be uniquely identified by an intrinsic identifier that is
guaranteed to remain stable over time.

Syntax: ``swh:<scheme_version>:<object_type>:<object_id>``

Examples:

- ``swh:1:cnt:94a9ed024d3859793618152ea559a168bbcbb5e2``
- ``swh:1:dir:d198bc9d7a6bcf6db04f476d29314f157507d505``
- ``swh:1:rev:309cf2674ee7a0749978cf8265ab91a60aea0f7d``

``object_id``: sha1 of object's content and metadata

SWH web app can be used to resolve a PID:
https://archive.softwareheritage.org/<identifier>

Objstorage
==========

Goal: API to manipulate SWH object storage (add, restore, get, check, delete,
etc.)

Scheduler
=========

Goal: keep track of scheduled tasks (eg: next listing/loading)

Implementation is based on Celery.

Storage
=======

https://docs.softwareheritage.org/devel/swh-storage/sql-storage.html
https://docs.softwareheritage.org/devel/swh-storage/archive-copies.html

Goal: abstraction layer over the archive to access artifacts and their metadata

Vault
=====

Goal: allows to retrieve parts of the archive as self-contained bundles (e.g.,
individual releases, entire repository snapshots, etc.)

Web
===

Goal: web apps to browse the archive
