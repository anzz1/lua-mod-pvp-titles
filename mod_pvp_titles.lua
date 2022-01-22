------------------------------------------------------------------------------------------------
-- PVP TITLES MOD
------------------------------------------------------------------------------------------------

local EnableModule = true
local AnnounceModule = true   -- Announce module on player login ?

------------------------------------------------------------------------------------------------
-- END CONFIG
------------------------------------------------------------------------------------------------

if (not EnableModule) then return end

require("ObjectVariables")
local FILE_NAME = string.match(debug.getinfo(1,'S').source, "[^/\\]*.lua$")

local PVP_KILLS = {
    [1] = 20,
    [2] = 100,
    [3] = 200,
    [4] = 400,
    [5] = 900,
    [6] = 1500,
    [7] = 2600,
    [8] = 4000,
    [9] = 7000,
    [10] = 12000,
    [11] = 19000,
    [12] = 30000,
    [13] = 42000,
    [14] = 60000
}

local PVP_TITLES = {
    [1] = {[0] = 1, [1] = 15},
    [2] = {[0] = 2, [1] = 16},
    [3] = {[0] = 3, [1] = 17},
    [4] = {[0] = 4, [1] = 18},
    [5] = {[0] = 5, [1] = 19},
    [6] = {[0] = 6, [1] = 20},
    [7] = {[0] = 7, [1] = 21},
    [8] = {[0] = 8, [1] = 22},
    [9] = {[0] = 9, [1] = 23},
    [10] = {[0] = 10, [1] = 24},
    [11] = {[0] = 11, [1] = 25},
    [12] = {[0] = 12, [1] = 26},
    [13] = {[0] = 13, [1] = 27},
    [14] = {[0] = 14, [1] = 28}
}

local PVP_FEATS = {
    [1] = {[0] = 442, [1] = 454},
    [2] = {[0] = 470, [1] = 468},
    [3] = {[0] = 471, [1] = 453},
    [4] = {[0] = 441, [1] = 450},
    [5] = {[0] = 440, [1] = 452},
    [6] = {[0] = 439, [1] = 451},
    [7] = {[0] = 472, [1] = 449},
    [8] = {[0] = 438, [1] = 469},
    [9] = {[0] = 437, [1] = 448},
    [10] = {[0] = 436, [1] = 447},
    [11] = {[0] = 435, [1] = 444},
    [12] = {[0] = 473, [1] = 446},
    [13] = {[0] = 434, [1] = 445},
    [14] = {[0] = 433, [1] = 443}
}

local function checkHonorKills(event, killer, killed)
    local kills = killer:GetLifetimeKills()
    if (kills ~= killer:GetData("_honor_kills")) then
        local team = killer:GetTeam()
        for i,v in ipairs(PVP_KILLS) do
            if (kills >= v) then
                if (not killer:HasTitle(PVP_TITLES[i][team])) then
                    killer:SetKnownTitle(PVP_TITLES[i][team])
                end
                if (not killer:HasAchieved(PVP_FEATS[i][team])) then
                    killer:SetAchievement(PVP_FEATS[i][team])
                end
            else
                break
            end
        end
        killer:SetData("_honor_kills", kills)
    end
end

local function moduleAnnounce(event, player)
    player:SendBroadcastMessage("This server is running the |cff4CFF00PVPTitles|r module.")
end

RegisterPlayerEvent(6, checkHonorKills) -- PLAYER_EVENT_ON_KILL_PLAYER
RegisterPlayerEvent(7, checkHonorKills) -- PLAYER_EVENT_ON_KILL_CREATURE

if (AnnounceModule) then
    RegisterPlayerEvent(3, moduleAnnounce)   -- PLAYER_EVENT_ON_LOGIN
end

PrintInfo("["..FILE_NAME.."] PVPTitles module loaded.")
