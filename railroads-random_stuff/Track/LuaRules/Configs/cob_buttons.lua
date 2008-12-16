-- $Id: cob_buttons.lua 3171 2008-11-06 09:06:29Z det $
return {
  test_track = {
	{
		cob = "Expand",
		name = "Expand",
		tooltip = "Expand rail system"},
	},
  test_station = {
	{
		cob = "Expand",
		name = "Expand",
		tooltip = "Expand rail system"
		},
	{
		cob = "SpawnTrain",
		name = "Spawn Train",
		tooltip = "Spawn a new Train"
		},
	},
  -- core_slicer = {
    -- {
      -- name     = "Sprint",
      -- tooltip  = "Charge!",
      -- cob      = "StartSprint",  -- only this is required
      -- endcob   = "StopSprint",  -- called at the end of duration
      -- reload   = 20,   -- button is disabled until the reload time has passed
      -- duration = 5,
      -- position = 500,              
    -- },
  -- },
  test_train = {
	{
		name     = "Forward",
		tooltip  = "Go Forward",
		cob      = "TrainForward"
	},
	{
		name     = "TrainStop",
		tooltip  = "Stop the Train",
		cob      = "TrainStop"
	},
	{
		name     = "Reverse",
		tooltip  = "Reverse the Train",
		cob      = "TrainReverse"
	},
  },
}