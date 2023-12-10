if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

--- Get all players id
---@return table
function GetPlayers(source)
	local xPlayers = ESX.GetPlayers()
    return xPlayers
end

--- Get a player job
---@return string
function GetPlayerJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.job.name
end

--- Add money to a player
---@param source number
---@param amount number
---@param reason string
function AddMoney(source, amount, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount(Config.MoneyType)
    xPlayer.setAccountMoney(Config.MoneyType, money + amount)
end