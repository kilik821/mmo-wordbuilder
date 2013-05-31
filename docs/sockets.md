# Documentation for socket interface

This is the documentation for the socket messages used for MMOWB.
All messages belong to a single namespace, '/'.
Messages are also given a *c-s*, *s-c*, *c-c* tag to mark them as client
to server, server to client, and client to client respectively.

## Login

### login (s-c)
---
Sent after a connection is started. Requests a login response from the client.

### login (c-s)
---
Sent in response to a login request.  Contains users account info.

    u: [String] Username
    p: [String] Password

## Chat

### send message (c-s)
---

Emits a message to all members of a chat room.

    r : [String] Room to emit message to
    m : [String] Message to send


### send message (s-c)
---

Sends a message to a client in a room.

    u : [String] Username of user who sent the message
    m : [String] Message sent
    
### join (c-s)
---

Allows a client to join a chat room.

    r : [String] Room to join

### leave (c-s)
---

Removes a client from a room.  Has no effect if the client is not in the room.

    r : [String] Room to leave
