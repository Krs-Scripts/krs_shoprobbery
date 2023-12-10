if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

--- Get a player job
---@return string
function GetPlayerJob()
    return PlayerData.job.name
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerData.gang = gang
end)