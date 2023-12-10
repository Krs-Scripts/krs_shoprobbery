local rob = false
local robbers = {}


RegisterNetEvent('krs_shoprobbery:tooFar', function(currentStore)
	local source = source
	local xPlayers = GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
		if GetPlayerJob(xPlayers[i]) == 'police' then
			TriggerClientEvent('ox_lib:notify', xPlayers[i], {type = 'Rapina annullata al: '..Config.ShopRobbery[currentStore].nomeNegozio, 6000})
			TriggerClientEvent('krs_shoprobbery:removeBlip', xPlayers[i])
		end
	end
	if robbers[source] then
		TriggerClientEvent('krs_shoprobbery:tooFar', source)
		robbers[source] = nil
		TriggerClientEvent('ox_lib:notify', source, {type = 'inform', description = 'Rapina annullata al: '..Config.ShopRobbery[currentStore].nomeNegozio, 6000})
	end
end)


lib.callback.register('krs_shoprobbery:policeinservice', function(source)
	local cops = 0
	local xPlayers = GetPlayers()
	for i=1, #xPlayers, 1 do
		if GetPlayerJob(xPlayers[i]) == 'police' then
			cops = cops + 1
		end
	end
	return cops
end)


RegisterNetEvent('krs_shoprobbery:robberyStarted', function(currentStore, job)
	local _source  = source
	local xPlayers = GetPlayers()

	if Config.ShopRobbery[currentStore] then
		local store = Config.ShopRobbery[currentStore]

		if (os.time() - store.prossimaRapina) < Config.TimerBeforeNewRob and store.prossimaRapina ~= 0 then
			TriggerClientEvent('ox_lib:notify', _source, {type = 'error', description = 'Questo negozio è gia stato rapinato, aspetta: '..Config.TimerBeforeNewRob - (os.time() - store.prossimaRapina), 6000})
		
			return
		end

		if not rob then
			rob = true

			for i=1, #xPlayers, 1 do
				if GetPlayerJob(xPlayers[i]) == 'police' then
					TriggerClientEvent('ox_lib:notify', xPlayers[i], {type = 'inform', description = 'la rapina è incorso: ' ..store.nomeNegozio, 6000})
					TriggerClientEvent('krs_shoprobbery:setBlip', xPlayers[i], Config.ShopRobbery[currentStore].position)
				end
			end

			TriggerClientEvent('ox_lib:notify', _source, {type = 'inform', description = 'Hai iniziato una rapina: ' ..store.nomeNegozio, 6000})
			TriggerClientEvent('ox_lib:notify', _source, {type = 'inform', description = 'L\'allarme ha avisato la polizia: ' ..store.nomeNegozio, 6000})
		
		
			TriggerClientEvent('krs_shoprobbery:currentlyRobbing', _source, currentStore)
			TriggerClientEvent('krs_shoprobbery:startTimer', _source)
			
			Config.ShopRobbery[currentStore].prossimaRapina = os.time()
			robbers[_source] = currentStore

			SetTimeout(store.tempoRapina * 1000, function()
				if robbers[_source] then
					rob = false
					TriggerClientEvent('krs_shoprobbery:robberyComplete', _source, store.guadagno)
					AddMoney(_source, store.guadagno, 'Shop robbery')
					local xPlayers, xPlayer = GetPlayers(), nil
					for i=1, #xPlayers, 1 do
						if GetPlayerJob(xPlayers[i]) == 'police' then
							TriggerClientEvent('ox_lib:notify', xPlayers[i], {type = 'inform', description = 'Rapina finita: '..store.nomeNegozio, 6000})
							TriggerClientEvent('krs_shoprobbery:removeBlip', xPlayers[i])
						end
					end
				end
			end)
		else
			TriggerClientEvent('ox_lib:notify', _source, {type = 'inform', description = 'E\' già in corso una rapina', 6000})
		end
	else 
		-- Log Discord
	end
end)
