-- Project 26-bis (Maxim Gorky) cruiser script
local deg, rad = math.deg, math.rad
local GetPieceRotation = Spring.UnitScript.GetPieceRotation

-- pieces are NOT local to avoid the limit of 200 local vars

--[[
	Weapons:
		1 - 3 - main guns (180mm)
		4 - 7 - 45mm AA guns (useless?)
		8 - 18 - 37mm AA guns
		19 - 20 - torpedo launchers
]]--

-- I'm not going to bother remembering all the powers of two...
SIG_MOVE = 1
SIG_AIM01 = SIG_MOVE * 2
SIG_AIM02 = SIG_AIM01 * 2
SIG_AIM03 = SIG_AIM02 * 2
SIG_AIM04 = SIG_AIM03 * 2
SIG_AIM05 = SIG_AIM04 * 2
SIG_AIM06 = SIG_AIM05 * 2
SIG_AIM07 = SIG_AIM06 * 2
SIG_AIM08 = SIG_AIM07 * 2
SIG_AIM09 = SIG_AIM08 * 2
SIG_AIM10 = SIG_AIM09 * 2
SIG_AIM11 = SIG_AIM10 * 2
SIG_AIM12 = SIG_AIM11 * 2
SIG_AIM13 = SIG_AIM12 * 2
SIG_AIM14 = SIG_AIM13 * 2
SIG_AIM15 = SIG_AIM14 * 2
SIG_AIM16 = SIG_AIM15 * 2
SIG_AIM17 = SIG_AIM16 * 2
SIG_AIM18 = SIG_AIM17 * 2
SIG_AIM19 = SIG_AIM18 * 2
SIG_AIM20 = SIG_AIM19 * 2
SIG_AIM21 = SIG_AIM20 * 2
SIG_AIM22 = SIG_AIM21 * 2
-- about 24 bitmasked signals are possible
SIG_AIM23 = {}
SIG_AIM24 = {}
SIG_AIM25 = {}
SIG_AIM26 = {}
-- there can be more, but they would have to be non-numeric

-- Turret turn rates
local MAIN_TURN_SPEED = rad(5)
local MAIN_PITCH_SPEED = rad(5)

local AA100_TURN_SPEED = rad(13)
local AA100_PITCH_SPEED = rad(13)

local AA37_TURN_SPEED = rad(30)
local AA37_PITCH_SPEED = rad(25)

-- Recoil distances
local MAIN_RECOIL = -10
local MAIN_RECOIL_SPEED = 40
local MAIN_RETURN_SPEED = 5

local AA100_RECOIL = -4
local AA100_RECOIL_SPEED = 40
local AA100_RETURN_SPEED = 15

local AA37_RECOIL = -1
local AA37_RECOIL_SPEED = 40
local AA37_RETURN_SPEED = 20

-- Variables to store multi-gun turret states
local gun1 = 1
local gun2 = 1
local gun3 = 1
local main_flares = {}
local main_barrels = {}
local torp_flares = {}
local torp1 = 1
local torp2 = 1

-- SFX defines
MEDIUM_MUZZLEFLASH = 1024+1
MEDIUM_MUZZLEDUST = 1024+2
SMALL_MUZZLEFLASH = 1024+3
SMALL_MUZZLEDUST = 1024+4
XSMALL_MUZZLEFLASH = 1024+5
XSMALL_MUZZLEDUST = 1024+6
MG_MUZZLEFLASH = 1024+7
LARGE_MUZZLEFLASH = 1024+8
LARGE_MUZZLEDUST = 1024+9

-- Aiming and other gun-related functions are generalized
-- Restore turret angles
function RestoreTurrets()
	-- exclude SIG_MOVE
	SetSignalMask(SIG_AIM20-2)
	-- wait for the largest gun to reload, and then some
	Sleep(Spring.UnitScript.GetLongestReloadTime(unitID)*1.5)
	-- main turrets
	for i=1, 2 do
		Turn(piece("main_turret_"..i), y_axis, 0, MAIN_TURN_SPEED)
		Turn(piece("main_sleeve_"..i), x_axis, 0, MAIN_PITCH_SPEED)
	end
	Turn(piece(main_turret_3), y_axis, rad(180), MAIN_TURN_SPEED)
	Turn(piece(main_sleeve_3), x_axis, 0, MAIN_PITCH_SPEED)
	-- 100mm turrets
	for i=1, 4 do
		Turn(piece("aa100_turret_"..i), y_axis, 0, AA100_TURN_SPEED)
		Turn(piece("aa100_sleeve_"..i), x_axis, 0, AA100_PITCH_SPEED)
	end
	for i=5, 6 do
		Turn(piece("aa100_turret_"..i), y_axis, rad(180), AA100_TURN_SPEED)
		Turn(piece("aa100_sleeve_"..i), x_axis, 0, AA100_PITCH_SPEED)
	end
	-- 45mm turrets
	for i=1, 2 do
		Turn(piece("aa45_turret_"..i), y_axis, 0, AA37_TURN_SPEED)
		Turn(piece("aa45_sleeve_"..i), y_axis, 0, AA37_PITCH_SPEED)
		Turn(piece("aa45_turret_"..i+2), y_axis, rad(180), AA37_TURN_SPEED)
		Turn(piece("aa45_sleeve_"..i+2), y_axis, 0, AA37_PITCH_SPEED)
	end
	-- 37mm turrets, forward facing
	-- that would be 1, 2, 5, 6
	for _, i in pairs({1, 2, 5, 6}) do
		Turn(piece("aa37_turret_"..i), y_axis, 0, AA37_TURN_SPEED)
		Turn(piece("aa37_sleeve_"..i), x_axis, 0, AA37_PITCH_SPEED)
	end
	-- backwards facing
	for _, i in pairs({3, 4, 7, 8, 9, 10, 11}) do
		Turn(piece("aa37_turret_"..i), y_axis, rad(180), AA37_TURN_SPEED)
		Turn(piece("aa37_sleeve_"..i), x_axis, 0, AA37_PITCH_SPEED)
	end
	-- torpedo tubes
	for i=1, 2 do
		Turn(piece("torp_turret_"..i), 0, MAIN_TURN_SPEED)
	end
end

local function AimTurretedWeapon(heading, pitch, turret, sleeve, signal, turn_speed, pitch_speed)
	-- Aim a generuc turret which has a sleeve
	Signal(signal)
	SetSignalMask(signal)
	Turn(turret, y_axis, heading, turn_speed)
	Turn(sleeve, x_axis, -pitch, pitch_speed)
	WaitForTurn(turret, y_axis)
	WaitForTurn(sleeve, x_axis)
	StartThread(RestoreTurrets)
	return true
end

local function AimTurretedWeapon_NoSleeve(heading, pitch, turret, signal, turn_speed, pitch_speed)
	-- Aim a turret which has NO sleeve
	Signal(signal)
	SetSignalMask(signal)
	Turn(turret, y_axis, heading, turn_speed)
	WaitForTurn(turret, y_axis)
	StartThread(RestoreTurrets)
	return true
end

local function FireGun(flare_piece, recoil_piece, recoil_distance, recoil_speed, return_speed, return_delay, SFX)
	-- Fire a generic weapon
	--Show(flare_piece)
	EmitSfx(flare_piece, SFX)
	Move(recoil_piece, z_axis, recoil_distance, recoil_speed)
	--Sleep(return_delay)
	--Hide(flare_piece)
	WaitForMove(recoil_piece, z_axis)
	Move(recoil_piece, z_axis, 0, return_speed)
end

-- End of generic fucntions

-- Some init stuff, to be called from Create
local function Init()
	-- here comes magic, thanks to Tobi
	-- this populates global namespace with all the piece names
	for k, v in pairs(Spring.GetUnitPieceMap(unitID)) do
		_G[k] = v
		-- auto-hide flares
		if string.find(k, 'flare', 1, true) then
			Hide(v)
		end
	end
	-- Fill main_flares and main_barrels tables
	-- loop trough 4 main turrets
	for i=1, 3 do
		-- each turret has 1 sleeve and 3 gun pieces
		main_flares[i]={}
		main_barrels[i]={}
		if (i<3) then
			torp_flares[i]={}
		end
		for j=1, 3 do
			main_flares[i][j]=piece("main_flare_"..i..j)
			main_barrels[i][j]=piece("main_barrel_"..i..j)
			if (i<3) then
				torp_flares[i][j]=piece("torp_flare_"..i..j)
			end
		end
	end
	-- Pre-position turrets
	Turn(main_turret_3, y_axis, rad(180))

	for i=4, 5 do
		Turn(piece("aa100_turret_"..i), y_axis, rad(180))
	end

	for i=3, 4 do
		Turn(piece('aa45_turret_'..i), y_axis, rad(180))
	end

	for _, i in pairs({3, 4, 7, 8, 9, 10, 11}) do
		Turn(piece("aa37_turret_"..i), y_axis, rad(180))
	end

	StartThread(DamageSmoke)
end

function DamageSmoke()
	-- emit some smoke if the unit is damaged
	-- check if the unit has finished building
	_,_,_,_,buildProgress = Spring.GetUnitHealth(unitID)
	while (buildProgress > 0) do
		Sleep(150)
		_,_,_,_,buildProgress = Spring.GetUnitHealth(unitID)
	end
	-- random delay between smoke start
	timeDelay = math.random(1, 5)*30
	Sleep(timeDelay)
	while (1 == 1) do
		curHealth, maxHealth = Spring.GetUnitHealth(unitID)
		healthState = curHealth/maxHealth
		if healthState<66 then
			EmitSfx(base, SFX.BLACK_SMOKE)
			-- the less HP we have left, the more often the smoke
			timeDelay = 500 * healthState
			-- no sence to make a delay shorter than a game frame
			if timeDelay<30 then
				timeDelay = 30
			end
		else
			timeDelay = 500
		end
		Sleep(timeDelay)
	end
end

-- Here the real guns start

-- 180mm turrets
function script.AimFromWeapon1()
	return main_turret_1
end

function script.QueryWeapon1()
	return main_flares[1][gun1]
end

function script.AimWeapon1(heading, pitch)
	AimTurretedWeapon(heading, pitch, main_turret_1, main_sleeve_1, SIG_AIM01, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon1()
	FireGun(main_flares[1][gun1], main_barrels[1][gun1], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot1()
	gun1 = gun1 + 1
	if gun1>3 then
		gun1 = 1
	end
end

function script.AimFromWeapon2()
	return main_turret_2
end

function script.QueryWeapon2()
	return main_flares[2][gun2]
end

function script.AimWeapon2(heading, pitch)
	AimTurretedWeapon(heading, pitch, main_turret_2, main_sleeve_2, SIG_AIM02, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon2()
	FireGun(main_flares[2][gun2], main_barrels[2][gun2], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot2()
	gun2 = gun2 + 2
	if gun2>3 then
		gun2 = 2
	end
end

function script.AimFromWeapon3()
	return main_turret_3
end

function script.QueryWeapon3()
	return main_flares[3][gun3]
end

function script.AimWeapon3(heading, pitch)
	AimTurretedWeapon(heading, pitch, main_turret_3, main_sleeve_3, SIG_AIM03, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon3()
	FireGun(main_flares[3][gun3], main_barrels[3][gun3], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot3()
	gun3 = gun3 + 3
	if gun3>3 then
		gun3 = 3
	end
end

-- 100mm guns (4, 5, 6, 7, 8, 9)
function script.AimFromWeapon4()
	return aa100_turret_1
end

function script.QueryWeapon4()
	return aa100_flare_1
end

function script.AimWeapon4(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_1, aa100_sleeve_1, SIG_AIM04, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon4()
	FireGun(aa100_flare_1, aa100_barrel_1, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot4()
end

function script.AimFromWeapon5()
	return aa100_turret_2
end

function script.QueryWeapon5()
	return aa100_flare_2
end

function script.AimWeapon5(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_2, aa100_sleeve_2, SIG_AIM05, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon5()
	FireGun(aa100_flare_2, aa100_barrel_2, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot5()
end

function script.AimFromWeapon6()
	return aa100_turret_3
end

function script.QueryWeapon6()
	return aa100_flare_3
end

function script.AimWeapon6(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_3, aa100_sleeve_3, SIG_AIM06, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon6()
	FireGun(aa100_flare_3, aa100_barrel_3, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot6()
end

function script.AimFromWeapon7()
	return aa100_turret_4
end

function script.QueryWeapon7()
	return aa100_flare_4
end

function script.AimWeapon7(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_4, aa100_sleeve_4, SIG_AIM07, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon7()
	FireGun(aa100_flare_4, aa100_barrel_4, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot7()
end

function script.AimFromWeapon8()
	return aa100_turret_5
end

function script.QueryWeapon8()
	return aa100_flare_5
end

function script.AimWeapon8(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_5, aa100_sleeve_5, SIG_AIM08, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon8()
	FireGun(aa100_flare_5, aa100_barrel_5, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot8()
end

function script.AimFromWeapon9()
	return aa100_turret_6
end

function script.QueryWeapon9()
	return aa100_flare_6
end

function script.AimWeapon9(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa100_turret_6, aa100_sleeve_6, SIG_AIM09, AA100_TURN_SPEED, AA100_PITCH_SPEED)
	return true
end

function script.FireWeapon9()
	FireGun(aa100_flare_6, aa100_barrel_6, AA100_RECOIL, AA100_RECOIL_SPEED, AA100_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot9()
end

-- 45mm AA guns
function script.AimFromWeapon10()
	return aa45_turret_1
end

function script.QueryWeapon10()
	return aa45_flare_1
end

function script.AimWeapon10(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa45_turret_1, aa45_sleeve_1, SIG_AIM10, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon10()
	FireGun(aa45_flare_1, aa45_barrel_1, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot10()
end

function script.AimFromWeapon11()
	return aa45_turret_2
end

function script.QueryWeapon11()
	return aa45_flare_2
end

function script.AimWeapon11(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa45_turret_2, aa45_sleeve_2, SIG_AIM11, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon11()
	FireGun(aa45_flare_2, aa45_barrel_2, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot11()
end

function script.AimFromWeapon12()
	return aa45_turret_3
end

function script.QueryWeapon12()
	return aa45_flare_3
end

function script.AimWeapon12(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa45_turret_3, aa45_sleeve_3, SIG_AIM12, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon12()
	FireGun(aa45_flare_3, aa45_barrel_3, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot12()
end

function script.AimFromWeapon13()
	return aa45_turret_4
end

function script.QueryWeapon13()
	return aa45_flare_4
end

function script.AimWeapon13(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa45_turret_4, aa45_sleeve_4, SIG_AIM13, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon13()
	FireGun(aa45_flare_4, aa45_barrel_4, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot13()
end

-- 37mm AA guns
function script.AimFromWeapon14()
	return aa37_turret_1
end

function script.QueryWeapon14()
	return aa37_flare_1
end

function script.AimWeapon14(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_1, aa37_sleeve_1, SIG_AIM14, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon14()
	FireGun(aa37_flare_1, aa37_barrel_1, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot14()
end

function script.AimFromWeapon15()
	return aa37_turret_2
end

function script.QueryWeapon15()
	return aa37_flare_2
end

function script.AimWeapon15(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_2, aa37_sleeve_2, SIG_AIM15, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon15()
	FireGun(aa37_flare_2, aa37_barrel_2, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot15()
end

function script.AimFromWeapon16()
	return aa37_turret_3
end

function script.QueryWeapon16()
	return aa37_flare_3
end

function script.AimWeapon16(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_3, aa37_sleeve_3, SIG_AIM16, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon16()
	FireGun(aa37_flare_3, aa37_barrel_3, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot16()
end

function script.AimFromWeapon17()
	return aa37_turret_4
end

function script.QueryWeapon17()
	return aa37_flare_4
end

function script.AimWeapon17(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_4, aa37_sleeve_4, SIG_AIM17, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon17()
	FireGun(aa37_flare_4, aa37_barrel_4, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot17()
end

function script.AimFromWeapon18()
	return aa37_turret_5
end

function script.QueryWeapon18()
	return aa37_flare_5
end

function script.AimWeapon18(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_5, aa37_sleeve_5, SIG_AIM18, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon18()
	FireGun(aa37_flare_5, aa37_barrel_5, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot18()
end

function script.AimFromWeapon19()
	return aa37_turret_6
end

function script.QueryWeapon19()
	return aa37_flare_6
end

function script.AimWeapon19(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_6, aa37_sleeve_6, SIG_AIM19, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon19()
	FireGun(aa37_flare_6, aa37_barrel_6, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot19()
end

function script.AimFromWeapon20()
	return aa37_turret_7
end

function script.QueryWeapon20()
	return aa37_flare_7
end

function script.AimWeapon20(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_7, aa37_sleeve_7, SIG_AIM20, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon20()
	FireGun(aa37_flare_7, aa37_barrel_7, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot20()
end

function script.AimFromWeapon21()
	return aa37_turret_8
end

function script.QueryWeapon21()
	return aa37_flare_8
end

function script.AimWeapon21(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_8, aa37_sleeve_8, SIG_AIM21, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon21()
	FireGun(aa37_flare_8, aa37_barrel_8, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot21()
end

function script.AimFromWeapon22()
	return aa37_turret_9
end

function script.QueryWeapon22()
	return aa37_flare_9
end

function script.AimWeapon22(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_9, aa37_sleeve_9, SIG_AIM22, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon22()
	FireGun(aa37_flare_9, aa37_barrel_9, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot22()
end

function script.AimFromWeapon23()
	return aa37_turret_10
end

function script.QueryWeapon23()
	return aa37_flare_10
end

function script.AimWeapon23(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_10, aa37_sleeve_10, SIG_AIM23, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon23()
	FireGun(aa37_flare_10, aa37_barrel_10, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot23()
end

function script.AimFromWeapon24()
	return aa37_turret_11
end

function script.QueryWeapon24()
	return aa37_flare_11
end

function script.AimWeapon24(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_11, aa37_sleeve_11, SIG_AIM24, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon24()
	FireGun(aa37_flare_11, aa37_barrel_11, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot24()
end

-- torpedo launchers
function script.AimFromWeapon25()
	return torp_turret_1
end

function script.QueryWeapon25()
	return torp_flares[1][torp1]	
end

function script.AimWeapon25(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, torp_turret_1, SIG_AIM25, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
end

function script.FireWeapon25()
end

function script.Shot25()
	torp1 = torp1 + 1
	if torp1 > 3 then
		torp1 = 1
	end
end

function script.AimFromWeapon26()
	return torp_turret_2
end

function script.QueryWeapon26()
	return torp_flares[2][torp2]
end

function script.AimWeapon26(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, torp_turret_2, SIG_AIM26, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
end

function script.FireWeapon26()
end

function script.Shot26()
	torp2 = torp2 + 1
	if torp2 > 3 then
		torp2 = 1
	end
end

-- Misc functions
function script.Create()
	Init()
end

function Wakes()
	-- this will produce wakes and smoke while the unit is moving
	SetSignalMask(SIG_MOVE)
	while (1 == 1) do
		EmitSfx(wake1, SFX.WAKE)
		EmitSfx(wake2, SFX.WAKE)
		EmitSfx(wake3, SFX.WAKE)
		EmitSfx(wake4, SFX.WAKE)
		EmitSfx(exhaust1, SFX.BLACK_SMOKE)
		EmitSfx(exhaust2, SFX.BLACK_SMOKE)
		Sleep(150)
	end
end

function script.StartMoving()
	-- spawn a thread which will produce wakes until signal-killed
	Signal(SIG_MOVE)
	StartThread(Wakes)
end

function script.StopMoving()
	Signal(SIG_MOVE)
end

function script.Killed(recentDamage, maxHealth)
	-- there really is no way to damage this unit past corpse1
	return 1
end