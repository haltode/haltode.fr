Publish-subscribe
-----------------

https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern

Messaging pattern where senders (= publishers) categorize published messages
instead of sending them directly to receivers (= subscribers), and where
subscribers express interest in some categories and receive messages without
knowledge of publishers.

Pros:

- network scalability
- loose coupling: publishers/subscribers do not need to know the existence of
  one another (in the server/client paradigm a client cannot post messages to
  the server while it is not running) => dynamic network topology

Cons:

- message delivery issues (side effect of loose coupling): need to design the
  pub/sub system carefully to provide stronger system properties that a
  particular application might require

Many pub/sub systems use a **message broker** as an intermediate.

Examples of pub/sub systems: news, atom, rss.

Message broker
--------------

https://en.wikipedia.org/wiki/Message_broker

Intermediate program that translates a message from the sender's protocol to the
messaging protocol of the receiver. The purpose is to minimize the mutual
awareness that applications should have of each other to exchange messages.

Multiple uses of message broker: route messages to one or more destinations,
transform messages into alternatives representation, perform message
aggregation/decomposition, respond to events/errors, etc.

Examples of message brokers: apache kafka, rabbitmq, redis.

Message queue
-------------

https://en.wikipedia.org/wiki/Message_queue

Paradigm used for inter-process communication (IPC) or inter-thread
communication within the same process. Sibling of the pub/sub pattern.

Provide an asynchronous communication protocol (ie: the sender and receiver do
not need to interact with the message queue at the same time). Messages placed
on the queue are stored until the recipient retrieves them.

Usage: a sysadmin setup the message queueing software and defines a named
message queue. An application listens for messages in the queue, while other
applications may transfer messages to this queue. Many options to consider:

- durability: messages can be kept in memory, on disk, or committed to a
  database
- security: which applications can read/write to the queue?
- message purging: do you need a lifetime limit?
- message filtering: a subscriber may only need to see some specific messages
- delivery policy: do you need to guarantee delivery?
- etc.

Examples of message queue: celery, rabbitmq, redis, zeromq.

ACID (atomicity, consistency, isolation, durability)
----------------------------------------------------

https://en.wikipedia.org/wiki/ACID_(computer_science)

Set of properties of database transactions (often composed of multiple
statements) intended to guarantee validity even in the event of errors, power
failures, etc.

Atomicity
~~~~~~~~~

Guarantees that each transaction is treated as a single unit (which either
succeeds completely or fails completely). If any statements constituting a
transaction fails to complete, the entire transaction fails and the database is
left unchanged (even in case of power failure, errors, crashes, etc.).

Implementation: read-copy update (keep a copy of the data before any changes
occurred), journaling (keeps track of changes not yet committed by recording the
intentions into a journal), etc.

Concistency
~~~~~~~~~~~

Ensures that a transaction can only bring the database from one valid state to
another (maintaining database invariants).

Isolation
~~~~~~~~~

Ensures that concurrent execution of transactions leaves the database in the
same state as if the transactions were executed sequentially.

Implementation: locks

Durability
~~~~~~~~~~

Guarantees that once a transaction is committed it will remain so even in case
of system failure (eg: power outage, crash, etc.).

Implementation: store in non-volatile memory.
