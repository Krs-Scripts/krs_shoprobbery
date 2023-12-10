if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

--- Get all players id
---@return table
function GetPlayers()
	local Players = QBCore.Functions.GetPlayers()
    return Players
end

--- Get a player job
---@param source number
---@return string
function GetPlayerJob(source)
    local Player = ESX.GetPlayerFromId(source)
    return Player.PlayerData.job.name
end

--- Add money to a player
---@param source number
---@param amount number
---@param reason string
function AddMoney(source, amount, reason)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney(Config.MoneyType, amount, reason)
end