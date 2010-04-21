local deg, rad = math.deg, math.rad
local GetPieceRotation = Spring.UnitScript.GetPieceRotation

-- pieces are NOT local to avoid the limit of 200 local vars
base, hull, railings1, railings2, boats = piece('base', 'hull', 'railings1', 'railings2', 'boats')
exhaust1, exhaust2, wake1, wake2, wake3, wake4 = piece('exhaust1', 'exhaust2', 'wake1', 'wake2', 'wake3', 'wake4')
main_turret1, main_turret2, main_turret3, main_turret4 = piece('main_turret1', 'main_turret2', 'main_turret3', 'main_turret4')
main_sleeve11, main_sleeve12, main_sleeve13 = piece('main_sleeve11', 'main_sleeve12', 'main_sleeve13')
main_sleeve21, main_sleeve22, main_sleeve23 = piece('main_sleeve21', 'main_sleeve22', 'main_sleeve23')
main_sleeve31, main_sleeve32, main_sleeve33 = piece('main_sleeve31', 'main_sleeve32', 'main_sleeve33')
main_sleeve41, main_sleeve42, main_sleeve43 = piece('main_sleeve41', 'main_sleeve42', 'main_sleeve43')
main_gun11, main_gun12, main_gun13 = piece('main_gun11', 'main_gun12', 'main_gun13')
main_gun21, main_gun22, main_gun23 = piece('main_gun21', 'main_gun22', 'main_gun23')
main_gun31, main_gun32, main_gun33 = piece('main_gun31', 'main_gun32', 'main_gun33')
main_gun41, main_gun42, main_gun43 = piece('main_gun41', 'main_gun42', 'main_gun43')
main_flare11, main_flare12, main_flare13 = piece('main_flare11', 'main_flare12', 'main_flare13')
main_flare21, main_flare22, main_flare23 = piece('main_flare21', 'main_flare22', 'main_flare23')
main_flare31, main_flare32, main_flare33 = piece('main_flare31', 'main_flare32', 'main_flare33')
main_flare41, main_flare42, main_flare43 = piece('main_flare41', 'main_flare42', 'main_flare43')
aa37_turret_11, aa37_sleeve_11, aa37_barrel_11, aa37_flare_11 = piece('aa37_turret_11', 'aa37_sleeve_11', 'aa37_barrel_11', 'aa37_flare_11')
aa37_turret_12, aa37_sleeve_12, aa37_barrel_12, aa37_flare_12 = piece('aa37_turret_12', 'aa37_sleeve_12', 'aa37_barrel_12', 'aa37_flare_12')
aa37_turret_13, aa37_sleeve_13, aa37_barrel_13, aa37_flare_13 = piece('aa37_turret_13', 'aa37_sleeve_13', 'aa37_barrel_13', 'aa37_flare_13')
aa37_turret_21, aa37_sleeve_21, aa37_barrel_21, aa37_flare_21 = piece('aa37_turret_21', 'aa37_sleeve_21', 'aa37_barrel_21', 'aa37_flare_21')
aa37_turret_22, aa37_sleeve_22, aa37_barrel_22, aa37_flare_22 = piece('aa37_turret_22', 'aa37_sleeve_22', 'aa37_barrel_22', 'aa37_flare_22')
aa37_turret_23, aa37_sleeve_23, aa37_barrel_23, aa37_flare_23 = piece('aa37_turret_23', 'aa37_sleeve_23', 'aa37_barrel_23', 'aa37_flare_23')
aa37_turret_31, aa37_sleeve_31, aa37_barrel_31, aa37_flare_31 = piece('aa37_turret_31', 'aa37_sleeve_31', 'aa37_barrel_31', 'aa37_flare_31')
aa37_turret_32, aa37_sleeve_32, aa37_barrel_32, aa37_flare_32 = piece('aa37_turret_32', 'aa37_sleeve_32', 'aa37_barrel_32', 'aa37_flare_32')
aa37_turret_33, aa37_sleeve_33, aa37_barrel_33, aa37_flare_33 = piece('aa37_turret_33', 'aa37_sleeve_33', 'aa37_barrel_33', 'aa37_flare_33')
aa37_turret_41, aa37_sleeve_41, aa37_barrel_41, aa37_flare_41 = piece('aa37_turret_41', 'aa37_sleeve_41', 'aa37_barrel_41', 'aa37_flare_41')
aa37_turret_42, aa37_sleeve_42, aa37_barrel_42, aa37_flare_42 = piece('aa37_turret_42', 'aa37_sleeve_42', 'aa37_barrel_42', 'aa37_flare_42')
aa37_turret_43, aa37_sleeve_43, aa37_barrel_43, aa37_flare_43 = piece('aa37_turret_43', 'aa37_sleeve_43', 'aa37_barrel_43', 'aa37_flare_43')
side_turret1, side_barrel1, side_flare1 = piece('side_turret1', 'side_barrel1', 'side_flare1')
side_turret2, side_barrel2, side_flare2 = piece('side_turret2', 'side_barrel2', 'side_flare2')
side_turret3, side_barrel3, side_flare3 = piece('side_turret3', 'side_barrel3', 'side_flare3')
side_turret4, side_barrel4, side_flare4 = piece('side_turret4', 'side_barrel4', 'side_flare4')
side_turret5, side_barrel5, side_flare5 = piece('side_turret5', 'side_barrel5', 'side_flare5')
side_turret6, side_barrel6, side_flare6 = piece('side_turret6', 'side_barrel6', 'side_flare6')
side_turret7, side_barrel7, side_flare7 = piece('side_turret7', 'side_barrel7', 'side_flare7')
side_turret8, side_barrel8, side_flare8 = piece('side_turret8', 'side_barrel8', 'side_flare8')
side_turret9, side_barrel9, side_flare9 = piece('side_turret9', 'side_barrel9', 'side_flare9')
side_turret10, side_barrel10, side_flare10 = piece('side_turret10', 'side_barrel10', 'side_flare10')
side_turret11, side_barrel11, side_flare11 = piece('side_turret11', 'side_barrel11', 'side_flare11')
side_turret12, side_barrel12, side_flare12 = piece('side_turret12', 'side_barrel12', 'side_flare12')
side_turret13, side_barrel13, side_flare13 = piece('side_turret13', 'side_barrel13', 'side_flare13')
side_turret14, side_barrel14, side_flare14 = piece('side_turret14', 'side_barrel14', 'side_flare14')
side_turret15, side_barrel15, side_flare15 = piece('side_turret15', 'side_barrel15', 'side_flare15')
side_turret16, side_barrel16, side_flare16 = piece('side_turret16', 'side_barrel16', 'side_flare16')
aa76_turret1, aa76_sleeve1, aa76_gun1, aa76_flare1 = piece('aa76_turret1', 'aa76_sleeve1', 'aa76_gun1', 'aa76_flare1')
aa76_turret2, aa76_sleeve2, aa76_gun2, aa76_flare2 = piece('aa76_turret2', 'aa76_sleeve2', 'aa76_gun2', 'aa76_flare2')
aa76_turret3, aa76_sleeve3, aa76_gun3, aa76_flare3 = piece('aa76_turret3', 'aa76_sleeve3', 'aa76_gun3', 'aa76_flare3')
aa76_turret4, aa76_sleeve4, aa76_gun4, aa76_flare4 = piece('aa76_turret4', 'aa76_sleeve4', 'aa76_gun4', 'aa76_flare4')
aa76_turret5, aa76_sleeve5, aa76_gun5, aa76_flare5 = piece('aa76_turret5', 'aa76_sleeve5', 'aa76_gun5', 'aa76_flare5')
aa76_turret6, aa76_sleeve6, aa76_gun6, aa76_flare6 = piece('aa76_turret6', 'aa76_sleeve6', 'aa76_gun6', 'aa76_flare6')
aa37_turret_01, aa37_sleeve_01, aa37_barrel_01, aa37_flare_01 = piece('aa37_turret_01', 'aa37_sleeve_01', 'aa37_barrel_01', 'aa37_flare_01')
aa37_turret_02, aa37_sleeve_02, aa37_barrel_02, aa37_flare_02 = piece('aa37_turret_02', 'aa37_sleeve_02', 'aa37_barrel_02', 'aa37_flare_02')

--[[
	Weapons:
		1 - 4 - main guns (12")
		5 - 20 - anti-mine battery (120mm)
		21 - 26 - 76mm heavy AA
		27 - 40 - 37mm light AA
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
SIG_AIM23 = SIG_AIM22 * 2
SIG_AIM24 = SIG_AIM23 * 2
SIG_AIM25 = SIG_AIM24 * 2
SIG_AIM26 = SIG_AIM25 * 2
SIG_AIM27 = SIG_AIM26 * 2
SIG_AIM28 = SIG_AIM27 * 2
SIG_AIM29 = SIG_AIM28 * 2
SIG_AIM30 = SIG_AIM29 * 2
SIG_AIM31 = SIG_AIM30 * 2
SIG_AIM32 = SIG_AIM31 * 2
SIG_AIM33 = SIG_AIM32 * 2
SIG_AIM34 = SIG_AIM33 * 2
SIG_AIM35 = SIG_AIM34 * 2
SIG_AIM36 = SIG_AIM35 * 2
SIG_AIM37 = SIG_AIM36 * 2
SIG_AIM38 = SIG_AIM37 * 2
SIG_AIM39 = SIG_AIM38 * 2
SIG_AIM40 = SIG_AIM39 * 2

-- Turret turn rates
local MAIN_TURN_SPEED = rad(5)
local MAIN_PITCH_SPEED = rad(5)

local SIDE_TURN_SPEED = rad(15)

local AA76_TURN_SPEED = rad(20)
local AA76_PITCH_SPEED = rad(15)

local AA37_TURN_SPEED = rad(30)
local AA37_PITCH_SPEED = rad(25)

-- Recoil distances
local MAIN_RECOIL = -20
local MAIN_RECOIL_SPEED = 40
local MAIN_RETURN_SPEED = 5

local SIDE_RECOIL = -5
local SIDE_RECOIL_SPEED = 40
local SIDE_RETURN_SPEED = 10

local AA76_RECOIL = -2.5
local AA76_RECOIL_SPEED = 40
local AA76_RETURN_SPEED = 15

local AA37_RECOIL = -1
local AA37_RECOIL_SPEED = 40
local AA37_RETURN_SPEED = 20

-- Variables to store multi-gun turret states
local gun1 = 1
local gun2 = 1
local gun3 = 1
local gun4 = 1
local main_flares = {}
local main_barrels = {}

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
WAKE = 3
BLACK_SMOKE = 256 + 2

-- Aiming and other gun-related functions are generalized
-- Restore turret angles
function RestoreTurrets()
	-- exclude SIG_MOVE
	SetSignalMask(SIG_AIM23-2)
	-- wait for the largest gun to reload, and then some
	Sleep(Spring.UnitScript.GetLongestReloadTime(unitID)*1.5)
	-- main turrets
	for i=1, 4 do
		Turn(piece("main_turret"..i), y_axis, rad(180)*(math.fmod(i+1, 2)), MAIN_TURN_SPEED)
		for j=1, 3 do
			Turn(piece("main_sleeve"..i..j), x_axis, 0, MAIN_PITCH_SPEED)
			-- 37mm guns on top the main turrets
			Turn(piece("aa37_turret_"..i..j), y_axis, 0, AA37_TURN_SPEED)
			Turn(piece("aa37_sleeve_"..i..j), x_axis, 0, AA37_PITCH_SPEED)
		end
	end
	-- side turrets
	for i=1, 8 do
		Turn(piece("side_turret"..i), y_axis, 0, SIDE_TURN_SPEED)
		Turn(piece("side_turret"..(i+8)), y_axis, rad(180), SIDE_TURN_SPEED)
	end
	-- 76mm turrets
	for i=1, 3 do
		Turn(piece("aa76_turret"..i), y_axis, 0, AA76_TURN_SPEED)
		Turn(piece("aa76_turret"..(i+3)), y_axis, rad(180), AA76_TURN_SPEED)
		Turn(piece("aa76_sleeve"..i), x_axis, 0, AA76_PITCH_SPEED)
		Turn(piece("aa76_sleeve"..(i+3)), x_axis, 0, AA76_PITCH_SPEED)
	end
	-- 37mm turrets NOT on top main guns
	for i=1, 2 do
		Turn(piece("aa37_turret_0"..i), y_axis, 0, AA37_TURN_SPEED)
		Turn(piece("aa37_sleeve_0"..i), x_axis, 0, AA37_PITCH_SPEED)
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

local function AimTripleTurret(heading, pitch, turret, sleeve1, sleeve2, sleeve3, signal, turn_speed, pitch_speed)
	-- Aim a 3-gun main turret
	Signal(signal)
	SetSignalMask(signal)
	Turn(turret, y_axis, heading, turn_speed)
	Turn(sleeve1, x_axis, -pitch, pitch_speed)
	Turn(sleeve2, x_axis, -pitch, pitch_speed)
	Turn(sleeve3, x_axis, -pitch, pitch_speed)
	WaitForTurn(turret, y_axis)
	WaitForTurn(sleeve1, x_axis)
	StartThread(RestoreTurrets)
	return true
end

-- End of generic fucntions
-- Some init stuff, to be called from Create
local function Init()
	-- Fill main_flares and main_barrels tables
	-- Hide main flares while we're at it
	-- loop trough 4 main turrets
	for i=1, 4 do
		-- each turret has 3 sleeve and 3 gun pieces
		main_flares[i]={}
		main_barrels[i]={}
		for j=1, 3 do
			main_flares[i][j]=piece("main_flare"..i..j)
			main_barrels[i][j]=piece("main_gun"..i..j)
			Hide(main_flares[i][j])
			Hide(piece("aa37_flare_"..i..j))
		end
	end
	-- Hide the rest of flares
	for i=1, 16 do
		Hide(piece("side_flare"..i))
	end
	for i=1, 6 do
		Hide(piece("aa76_flare"..i))
	end
	Hide(aa37_flare_01)
	Hide(aa37_flare_02)
	-- Pre-position turrets
	Turn(main_turret2, y_axis, rad(180))
	Turn(main_turret4, y_axis, rad(180))
	for i=4, 6 do
		Turn(piece("aa76_turret"..i), y_axis, rad(180))
	end
	for i=9, 16 do
		Turn(piece("side_turret"..i), y_axis, rad(180))	
	end
end

-- Here the real guns start

-- 12" turrets
function script.AimFromWeapon1()
	return main_turret1
end

function script.QueryWeapon1()
	return main_flares[1][gun1]
end

function script.AimWeapon1(heading, pitch)
	AimTripleTurret(heading, pitch, main_turret1, main_sleeve11, main_sleeve12, main_sleeve13, SIG_AIM01, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
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
	return main_turret2
end

function script.QueryWeapon2()
	return main_flares[2][gun2]
end

function script.AimWeapon2(heading, pitch)
	AimTripleTurret(heading, pitch, main_turret2, main_sleeve21, main_sleeve22, main_sleeve23, SIG_AIM02, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon2()
	FireGun(main_flares[2][gun2], main_barrels[2][gun2], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot2()
	gun2 = gun2 + 1
	if gun2>3 then
		gun2 = 1
	end
end

function script.AimFromWeapon3()
	return main_turret3
end

function script.QueryWeapon3()
	return main_flares[3][gun3]
end

function script.AimWeapon3(heading, pitch)
	AimTripleTurret(heading, pitch, main_turret3, main_sleeve31, main_sleeve32, main_sleeve33, SIG_AIM03, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon3()
	FireGun(main_flares[3][gun3], main_barrels[3][gun3], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot3()
	gun3 = gun3 + 1
	if gun3>3 then
		gun3 = 1
	end
end

function script.AimFromWeapon4()
	return main_turret4
end

function script.QueryWeapon4()
	return main_flares[4][gun4]
end

function script.AimWeapon4(heading, pitch)
	AimTripleTurret(heading, pitch, main_turret4, main_sleeve41, main_sleeve42, main_sleeve43, SIG_AIM04, MAIN_TURN_SPEED, MAIN_PITCH_SPEED)
	return true
end

function script.FireWeapon4()
	FireGun(main_flares[4][gun4], main_barrels[4][gun4], MAIN_RECOIL, MAIN_RECOIL_SPEED, MAIN_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot4()
	gun4 = gun4 + 1
	if gun4>3 then
		gun4 = 1
	end
end

-- 120mm antimine battery
function script.AimFromWeapon5()
	return side_turret1
end

function script.QueryWeapon5()
	return side_flare1
end

function script.AimWeapon5(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret1, SIG_AIM05, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon5()
	FireGun(side_flare1, side_barrel1, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot5()
end

function script.AimFromWeapon6()
	return side_turret2
end

function script.QueryWeapon6()
	return side_flare2
end

function script.AimWeapon6(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret2, SIG_AIM06, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon6()
	FireGun(side_flare2, side_barrel2, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot6()
end

function script.AimFromWeapon7()
	return side_turret3
end

function script.QueryWeapon7()
	return side_flare3
end

function script.AimWeapon7(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret3, SIG_AIM07, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon7()
	FireGun(side_flare3, side_barrel3, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot7()
end

function script.AimFromWeapon8()
	return side_turret4
end

function script.QueryWeapon8()
	return side_flare4
end

function script.AimWeapon8(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret4, SIG_AIM08, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon8()
	FireGun(side_flare4, side_barrel4, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot8()
end

function script.AimFromWeapon9()
	return side_turret5
end

function script.QueryWeapon9()
	return side_flare5
end

function script.AimWeapon9(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret5, SIG_AIM09, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon9()
	FireGun(side_flare5, side_barrel5, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot9()
end

function script.AimFromWeapon10()
	return side_turret6
end

function script.QueryWeapon10()
	return side_flare6
end

function script.AimWeapon10(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret6, SIG_AIM10, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon10()
	FireGun(side_flare6, side_barrel6, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot10()
end

function script.AimFromWeapon11()
	return side_turret7
end

function script.QueryWeapon11()
	return side_flare7
end

function script.AimWeapon11(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret7, SIG_AIM11, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon11()
	FireGun(side_flare7, side_barrel7, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot11()
end

function script.AimFromWeapon12()
	return side_turret8
end

function script.QueryWeapon12()
	return side_flare8
end

function script.AimWeapon12(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret8, SIG_AIM12, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon12()
	FireGun(side_flare8, side_barrel8, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot12()
end

function script.AimFromWeapon13()
	return side_turret9
end

function script.QueryWeapon13()
	return side_flare9
end

function script.AimWeapon13(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret7, SIG_AIM13, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon13()
	FireGun(side_flare9, side_barrel9, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot13()
end

function script.AimFromWeapon14()
	return side_turret10
end

function script.QueryWeapon14()
	return side_flare10
end

function script.AimWeapon14(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret10, SIG_AIM14, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon14()
	FireGun(side_flare10, side_barrel10, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot14()
end

function script.AimFromWeapon15()
	return side_turret11
end

function script.QueryWeapon15()
	return side_flare11
end

function script.AimWeapon15(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret11, SIG_AIM15, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon15()
	FireGun(side_flare11, side_barrel11, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot15()
end

function script.AimFromWeapon16()
	return side_turret12
end

function script.QueryWeapon16()
	return side_flare12
end

function script.AimWeapon16(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret12, SIG_AIM16, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon16()
	FireGun(side_flare12, side_barrel12, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot16()
end

function script.AimFromWeapon17()
	return side_turret13
end

function script.QueryWeapon17()
	return side_flare13
end

function script.AimWeapon17(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret13, SIG_AIM17, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon17()
	FireGun(side_flare13, side_barrel13, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot17()
end

function script.AimFromWeapon18()
	return side_turret14
end

function script.QueryWeapon18()
	return side_flare14
end

function script.AimWeapon18(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret14, SIG_AIM18, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon18()
	FireGun(side_flare14, side_barrel14, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot18()
end

function script.AimFromWeapon19()
	return side_turret15
end

function script.QueryWeapon19()
	return side_flare15
end

function script.AimWeapon19(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret15, SIG_AIM15, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon19()
	FireGun(side_flare15, side_barrel15, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot19()
end

function script.AimFromWeapon20()
	return side_turret16
end

function script.QueryWeapon20()
	return side_flare16
end

function script.AimWeapon20(heading, pitch)
	AimTurretedWeapon_NoSleeve(heading, pitch, side_turret16, SIG_AIM20, SIDE_TURN_SPEED)
	return true
end

function script.FireWeapon20()
	FireGun(side_flare16, side_barrel16, SIDE_RECOIL, SIDE_RECOIL_SPEED, SIDE_RETURN_SPEED, 150, LARGE_MUZZLEFLASH)
end

function script.Shot20()
end

-- 76mm AA guns
function script.AimFromWeapon21()
	return aa76_turret1
end

function script.QueryWeapon21()
	return aa76_flare1
end

function script.AimWeapon21(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret1, aa76_sleeve1, SIG_AIM21, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon21()
	FireGun(aa76_flare1, aa76_gun1, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot21()
end

function script.AimFromWeapon22()
	return aa76_turret2
end

function script.QueryWeapon22()
	return aa76_flare2
end

function script.AimWeapon22(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret2, aa76_sleeve2, SIG_AIM22, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon22()
	FireGun(aa76_flare2, aa76_gun2, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot22()
end

function script.AimFromWeapon23()
	return aa76_turret3
end

function script.QueryWeapon23()
	return aa76_flare3
end

function script.AimWeapon23(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret3, aa76_sleeve3, SIG_AIM23, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon23()
	FireGun(aa76_flare3, aa76_gun3, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot23()
end

function script.AimFromWeapon24()
	return aa76_turret4
end

function script.QueryWeapon24()
	return aa76_flare4
end

function script.AimWeapon24(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret4, aa76_sleeve4, SIG_AIM24, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon24()
	FireGun(aa76_flare4, aa76_gun4, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot24()
end

function script.AimFromWeapon25()
	return aa76_turret5
end

function script.QueryWeapon25()
	return aa76_flare5
end

function script.AimWeapon25(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret5, aa76_sleeve5, SIG_AIM25, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon25()
	FireGun(aa76_flare5, aa76_gun5, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot25()
end

function script.AimFromWeapon26()
	return aa76_turret6
end

function script.QueryWeapon26()
	return aa76_flare6
end

function script.AimWeapon26(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa76_turret6, aa76_sleeve6, SIG_AIM26, AA76_TURN_SPEED, AA76_PITCH_SPEED)
	return true
end

function script.FireWeapon26()
	FireGun(aa76_flare6, aa76_gun6, AA76_RECOIL, AA76_RECOIL_SPEED, AA76_RETURN_SPEED, 150, MEDIUM_MUZZLEFLASH)
end

function script.Shot26()
end

-- 37mm AA guns
function script.AimFromWeapon27()
	return aa37_turret_01
end

function script.QueryWeapon27()
	return aa37_flare_01
end

function script.AimWeapon27(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_01, aa37_sleeve_01, SIG_AIM27, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon27()
	FireGun(aa37_flare_01, aa37_barrel_01, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot27()
end

function script.AimFromWeapon28()
	return aa37_turret_02
end

function script.QueryWeapon28()
	return aa37_flare_02
end

function script.AimWeapon28(heading, pitch)
	AimTurretedWeapon(heading, pitch, aa37_turret_02, aa37_sleeve_02, SIG_AIM28, AA37_TURN_SPEED, AA37_PITCH_SPEED)
	return true
end

function script.FireWeapon28()
	FireGun(aa37_flare_02, aa37_barrel_02, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.Shot28()
end

-- 37mm on first main caliber turret
function script.AimFromWeapon29()
	return aa37_turret_11
end

function script.QueryWeapon29()
	return aa37_flare_11
end

function script.AimWeapon29(heading, pitch)
	local tmpHeading
	_,tmpHeading,_ = GetPieceRotation(main_turret1)
	AimTurretedWeapon(heading-tmpHeading, pitch, aa37_turret_11, aa37_sleeve_11, SIG_AIM29, AA37_TURN_SPEED, AA37_PITCH_SPEED)
end

function script.FireWeapon29()
	FireGun(aa37_flare_11, aa37_barrel_11, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.AimFromWeapon30()
	return aa37_turret_12
end

function script.QueryWeapon30()
	return aa37_flare_12
end

function script.AimWeapon30(heading, pitch)
	local tmpHeading
	_,tmpHeading,_ = GetPieceRotation(main_turret1)
	AimTurretedWeapon(heading-tmpHeading, pitch, aa37_turret_12, aa37_sleeve_12, SIG_AIM30, AA37_TURN_SPEED, AA37_PITCH_SPEED)
end

function script.FireWeapon30()
	FireGun(aa37_flare_12, aa37_barrel_12, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

function script.AimFromWeapon31()
	return aa37_turret_13
end

function script.QueryWeapon31()
	return aa37_flare_13
end

function script.AimWeapon31(heading, pitch)
	local tmpHeading
	_,tmpHeading,_ = GetPieceRotation(main_turret1)
	AimTurretedWeapon(heading-tmpHeading, pitch, aa37_turret_13, aa37_sleeve_13, SIG_AIM31, AA37_TURN_SPEED, AA37_PITCH_SPEED)
end

function script.FireWeapon31()
	FireGun(aa37_flare_13, aa37_barrel_13, AA37_RECOIL, AA37_RECOIL_SPEED, AA37_RETURN_SPEED, 150, SMALL_MUZZLEFLASH)
end

-- Misc functions
function script.Create()
	Init()
end

function Wakes()
	-- this will produce wakes and smoke while the unit is moving
	SetSignalMask(SIG_MOVE)
	while (1 == 1) do
		EmitSfx(wake1, WAKE)
		EmitSfx(wake2, WAKE)
		EmitSfx(wake3, WAKE)
		EmitSfx(wake4, WAKE)
		EmitSfx(exhaust1, BLACK_SMOKE)
		EmitSfx(exhaust2, BLACK_SMOKE)
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