function CreateRailTrack(unitID, unitDefID, teamID, punitCOBID, pteamID, tmpx, tmpy, tmpz, tmpdir, tmplinknum)
-- Create a unit using its CobId, place it at the specified coords
	-- Spring.Echo("CreateRailTrack(".. punitCOBID ..";".. pteamID ..";".. tmpx ..";".. tmpy ..";".. tmpz ..";".. tmpdir ..")")
	if punitCOBID ~= nil then
		if pteamID ~= nil then
		-- Find unitdef id for given CobID
			local tmpud, newUnit, newLinkNum
			for _,tmpud in pairs(UnitDefs) do
				if tmpud.cobID == punitCOBID then
					-- Spring.Echo("unitDef " .. tmpud.name)
					newUnit = Spring.CreateUnit(tmpud.name, tmpx, tmpy, tmpz, tmpdir, pteamID)
					-- Link the new track back to the one that spawned it
					if tmplinknum == 1 then newLinkNum = 2 else newLinkNum = 1 end
					-- Spring.Echo("Trying to connect unit "..newUnit.." to unit "..unitID)
					Spring.CallCOBScript(unitID, "SetLink", 0, newUnit, tmplinknum, newLinkNum)
					Spring.CallCOBScript(newUnit, "SetLink", 0, unitID, newLinkNum, tmplinknum)
				end
			end
		end
	end
end

function TrainToNextTrackSection(unitID, unitDefID, teamID, pTrainID, pNewSectionID, pNewLink)
-- Send a train to the specified track section
	-- Notify the train it's on a new section now
	Spring.CallCOBScript(pTrainID, "SetTrackSection", 0, pNewSectionID);
	-- Notify the section a train entered it
	Spring.CallCOBScript(pNewSectionID, "TrainEnters", 0, pTrainID, pNewLink);
end

function CreateTrain(unitID, unitDefID, teamID, pTrainID, pTeamID, pStationID, px, py, pz, pdir)
-- Spawn a new train at the specified point
	if pTrainID ~= nil then
		if pTeamID ~= nil then
		-- Find unitdef id for given CobID
			local tmpud, newUnit, newLinkNum
			for _,tmpud in pairs(UnitDefs) do
				if tmpud.cobID == pTrainID then
					Spring.Echo("Creating a train")
					newUnit = Spring.CreateUnit(tmpud.name, px, py, pz, pdir, pTeamID)
					-- Link the new train to the station
					Spring.CallCOBScript(pStationID, "TrainEnters", 0, newUnit, 0)
					-- Notify the train it's on track now
					Spring.CallCOBScript(newUnit, "SetTrackSection", 0, pStationID);
				end
			end
		end
	end
end

function SendCommandToTrain(unitID, unitDefID, teamID, pTrainID, pCommandID)
	-- Send a command to train
	Spring.CallCOBScript(pTrainID, "ReceiveCommand", 0, pCommandID)
end

function TrainSetPosition(unitID, unitDefID, teamID, pTrainID, px, py, pz, pdir)
	-- Set a train's position
	Spring.SetUnitPosition(pTrainID, px, pz)
end

function TrainCommand(unitID, unitDefID, teamID, pTrackID, pCommandID)
	-- Send a command from train to tracks
	Spring.CallCOBScript(pTrackID, "CommandFromTrain", 0, pCommandID)
end