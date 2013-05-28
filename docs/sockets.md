# Documentation for socket interface

This is the documentation for the socket messages used for MMOWB.
Messages are categorized into namespaces corresponding to 
<pre><code>io.of(NAMESPACE)</code></pre>
Messages are also given a *cts*, *stc*, *ctc* tag to mark them as client
to server, server to client, and client to client respectively.

## Chat

Messages in the "/chat" namespace

### send message (*cts*)
---

Emits a message to all members of a chat room.

    r : [String] Room to emit message to

    m : [String] Message to send

### join (*cts*)
---

Allows a client to join a chat room.

    r : [String] Room to join

### leave (*cts*)
---

Removes a client from a room.  Has no effect if the client is not in the room.

    r : [String] Room to leave
