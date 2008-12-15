Unit BOS (train):

TrainStop()			// command to play stop anim and send stop signal to the track
TrainForward()			// command to play forward anim and send forward signal to the track
TrainReverse()			// command to play reverse anim and send reverse signal to the track
or maybe just TrainCommand(commandID) - not yet decided
TrainSetHeading(newHeading)	// command from track to set unit heading

Unit BOS (track):

SetLink(unitId, ownLinkNum, otherLinkNum)		// which link we connect to on given exit, and to which exit of that link
TrainEnters(unitId, linkNum)	// a train enters the link, we'll need its id
CommandFromTrain(commandId)	// either forward, reverse or stop

Lua control:

On the train unit - 3 buttons (forward, reverse, stop). If pressed, they send the command to the train, which in turn informs the track of the new condition.

Lua is also responsible for keeping track of destroyed links and notifying the tracks they aren't connected anymore.

Moving the train is track's job, train unit is immobile on its own. The track has a 'train' piece that moves from link1 to link2 (or vice versa if in reverse mode), actual train unit position and heading are updated every frame to match that of the piece. If the track receives a command from the train, it stops or reverses the piece movement. If the piece reaches either end of track section, the train either stops (if there are no further track) or is passed on to that another section.

Trains are built via special 'train yard' unit which is a track piece as well. Tracks are built via each other.

Tracks have the 'Expand' button which tries to build a new section at each unoccupied end.

A track section can only house 1 train unit and will not allow any more of them to enter until that one leaves.

Tracks can in the future have switches - an additional button that determines the exit piece of a track (in case of more than 2 exit pieces). Signals that will block a section are also planned.