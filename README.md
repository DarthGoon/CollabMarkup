CollabMarkup
============

prototype for collaborative markups 
http://srproto.apphb.com/

Essentially a transparent multi-user whiteboard that you could slap on top on web content- to annotate it in some way.
This repo was a prototype/proof of concept.
So please pardon the excessive website template.  I did a "File-New Project" and just hit 'ok'.

At the core of this functionality-
Is an HTML5 canvas.  A socket connection.  And a server side cached representation of user actions (in the form of drawn coordinates).

You click on the canvas-
Client sends the mouse coordinates relative to the canvas element to the server via open socket-
Server records the coordinates and broadcasts to other connected clients.
Clients get the new coordinate, and render a "drawn" pixel at the location of the coordinates.

Like i said, pardon the excessive site template, i haven't cared to clean up the prototype as yet.
All you really need here is an HTML5 capable browser, some javascript knowledge, and a web socket endpoint that can track it's users and send them data.
