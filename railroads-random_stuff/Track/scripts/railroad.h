#ifndef _RAILROAD_H_
#define _RAILROAD_H_

#include "train_commands.h"
#include "exptype.h"

static-var bTrainHere, trainDirection;

lua_TrainSetPosition(unitId, x, y, z, dir)
{
	return 0;
}

lua_TrainToNextTrackSection(unitId, nextSectionId, LinkId)
{
	return 0;
}

lua_SendCommandToTrain(unitId, commandId)
{
	return 0;
}

lua_CreateRailTrack(unitID, teamID, x, y, z, dir, linknum)
{
}

SetLink(unitId, ownLinkNum, otherLinkNum)
{
	if(ownLinkNum == 1)
	{
		link1Id = unitId;
		otherLink1 = otherLinkNum;
	}
	if(ownLinkNum == 2)
	{
		link2Id = unitId;
		otherLink2 = otherLinkNum;
	}
}

UpdateTrain()
{
	var	x, y, z, xz, dir;
	set-signal-mask SIG_STOP|SIG_DEATH|SIG_TRAINENTER;
	while(bTrainHere)
	{
		sleep 30;
		xz=get PIECE_XZ(train);
		x=xz/65536;
		z=xz MOD 65536;
		y=get PIECE_Y(train);
		dir=get HEADING;
		call-script lua_TrainSetPosition(trainId, x, y, z, dir);
	}
}

CheckTrainStatus()
{
	set-signal-mask SIG_STOP|SIG_DEATH|SIG_TRAINENTER;
	wait-for-move train along z-axis;
	if(trainDirection == 1)
	{
		// Pass the train to the next track section, if any
		if(link2Id > 0)
		{
			// there is a piece of track after this one
			bTrainHere = FALSE;
			call-script lua_TrainToNextTrackSection(trainId, link2Id, otherLink2);
			trainId = 0;
			signal SIG_STOP;
		} else {
			// no track beyond here, let's send the train back
			call-script lua_SendCommandToTrain(trainId, TRAIN_COMMAND_REVERSE);
			// call-script CommandFromTrain(TRAIN_COMMAND_REVERSE);
			trainDirection = -1;
		}
	}
	if(trainDirection == 2)
	{
		// Pass the train to the next track section, if any
		if(link1Id > 0)
		{
			// there is a piece of track after this one
			bTrainHere = FALSE;
			call-script lua_TrainToNextTrackSection(trainId, link1Id, otherLink1);
			trainId = 0;
			signal SIG_STOP;
		} else {
			// no track beyond here, let's send the train back (back forward in this case)
			call-script lua_SendCommandToTrain(trainId, TRAIN_COMMAND_FORWARD);
			//call-script CommandFromTrain(TRAIN_COMMAND_FORWARD);
			trainDirection = 1;
		}
	}
	// no special action for a stopped train
}

TrainGo()
{
	signal SIG_STOP;
	if (trainDirection == 1)
	{
		move train to z-axis LINK2_Z speed TRAIN_SPEED;
	}
	if (trainDirection == -1)
	{
		move train to z-axis LINK1_Z speed TRAIN_SPEED;
	}
	// No need to check if stopped
	if (trainDirection != 0)
	{
		start-script CheckTrainStatus();
		start-script UpdateTrain();
	}
}

CommandFromTrain(commandId)
{
	if (commandID == TRAIN_COMMAND_STOP)
	{
		signal SIG_STOP;
		trainDirection = 0;
		move train to z-axis 0 speed 0;
	}
	if (commandId == TRAIN_COMMAND_FORWARD)
	{
		signal SIG_STOP;
		trainDirection = 1;
	}
	if (commandId == TRAIN_COMMAND_REVERSE)
	{
		signal SIG_STOP;
		trainDirection = -1;
	}
	start-script TrainGo();
}

TrainEnters(unitId, linkNum)
{
	signal SIG_TRAINENTER;
	set-signal-mask SIG_TRAINENTER|SIG_DEATH;
	bTrainHere = TRUE;
	trainId = unitId;
	if(linkNum == 1)
	{
		trainDirection = 1;
		move train to z-axis LINK1_Z now;
	} else {
		trainDirection = -1;
		move train to z-axis LINK2_Z now;
	}
	start-script TrainGo();
}

#endif
