AllowUnsafeChanges("USE AT YOUR OWN PERIL")

VFS.Include("LuaGadgets/gadgets.lua",nil, VFS.BASE)
-- VFS.Include("luacob.lua",nil, VFS.BASE)
VFS.Include"LuaRules/rail.lua"

function UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerUnitDefID, attackerTeamID)
	if attackerID == nil then
		-- What was that that killed us? Nothing?
	else
		Spring.CallCOBScript(attackerID, "TargetDestroyed", 2, unitID, TeamID)
	end
end

function OrderHeading(unitID, unitDefID, teamID, newHeading)
	if unitID == nil then
	else
		Spring.CallCOBScript(unitID, "AssumeHeading", 1, newHeading)
	end
end

function ReadRandomRace(unitID, unitDefID, teamID)
	Spring.Echo("Random race requested for team "..teamID..", calling unitID: "..unitID)
	if unitID ~= nil then
		if Spring.GetModOptions()["all_random_sides"]=="1" then
			Spring.CallCOBScript(unitID, "ChangeSide", 1, 0)
		end
	end
end

function CreateUnitByCobID(unitID, unitDefID, teamID, punitCOBID, pteamID, tmpx, tmpy, tmpz, tmpdir)
-- Create a unit using its CobId, place it at the specified coords
	-- Spring.Echo("CreateUnitByCobID(".. punitCOBID ..";".. pteamID ..";".. tmpx ..";".. tmpy ..";".. tmpz ..";".. tmpdir ..")")
	if punitCOBID ~= nil then
		if pteamID ~= nil then
		-- Find unitdef id for given CobID
			local tmpud
			for _,tmpud in pairs(UnitDefs) do
				if tmpud.cobID == punitCOBID then
					-- Spring.Echo("unitDef " .. tmpud.name)
					Spring.CreateUnit(tmpud.name, tmpx, tmpy, tmpz, tmpdir, pteamID)
				end
			end
		end
	end
end

function InitModOptions(unitID, unitDefID, teamID)
	if unitID ~= nil then
		Spring.Echo("Loading mod options...")
		Spring.SetUnitCOBValue(unitID, 4096+0, 1)
		-- engine sounds - quite annoying to some people
		local intruderSounds, humanSounds
		intruderSounds = 1 - Spring.GetModOptions()["int_no_engine_sound"]
		humanSounds = 1 - Spring.GetModOptions()["hum_no_engine_sound"]
		Spring.SetUnitCOBValue(unitID, 4096+2, humanSounds)
		Spring.SetUnitCOBValue(unitID, 4096+1, intruderSounds)
		Spring.Echo("Disable Human sounds: "..humanSounds..", Intruder sounds: "..intruderSounds)
		-- additional starting units
		local humStartCon, intStartCon, humStartAdvCon, humStartAdvCon2, intStartAdvcon
		humStartCon = Spring.GetModOptions()["hum_start_con"]
		intStartCon = Spring.GetModOptions()["int_start_con"]
		humStartAdvCon = Spring.GetModOptions()["hum_start_advcon"]
		humStartAdvCon2 = Spring.GetModOptions()["hum_start_advcon2"]
		intStartAdvCon = Spring.GetModOptions()["int_start_advcon"]
		Spring.SetUnitCOBValue(unitID, 4096+3, humStartCon)
		Spring.SetUnitCOBValue(unitID, 4096+4, intStartCon)
		Spring.SetUnitCOBValue(unitID, 4096+5, humStartAdvCon)
		Spring.SetUnitCOBValue(unitID, 4096+6, humStartAdvCon2)
		Spring.SetUnitCOBValue(unitID, 4096+7, intStartAdvCon)
		Spring.Echo("Additional starting units:")
		Spring.Echo("human con. unit: "..humStartCon)
		Spring.Echo("human adv. con. unit: "..humStartAdvCon)
		Spring.Echo("human adv. con. unit 2: "..humStartAdvCon2)
		Spring.Echo("intruder con. unit: "..intStartCon)
		Spring.Echo("intruder adv. con. unit: "..intStartAdvCon)
	end
end

-- MoveCtrl stuff

local MC=Spring.MoveCtrl

function EnableMoveCtrl(unitID, unitDefID, teamID)
	if (unitID) then
		MC.Enable(unitID)
	end
end

function DisableMoveCtrl(unitID, unitDefID, teamID)
	if (unitID) then
		MC.Disable(unitID)
	end
end

function MoveCtrlSetGravity(unitID, unitDefID, teamID, newGravity)
	if (unitID) then
		MC.SetGravity(unitID, newGravity)
	end
end

function MoveCtrlSetPhysics(unitID, unitDefID, teamID, posX, posY, posZ, velX, velY, velZ, rotX, rotY, rotZ)
	if (unitID) then
		MC.SetPhysics(unitID, posX, posY, posZ, velX, velY, velZ, rotX, rotY, rotZ)
	end
end