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
					if tmpLinkNum == 1 then newLinkNum = 2 else newLinkNum = 1 end
					Spring.CallCOBScript(unitID, "SetLink", 0, newUnit, tmpLinkNum, newLinkNum)
				end
			end
		end
	end
end
