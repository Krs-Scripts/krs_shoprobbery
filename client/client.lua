local holdingUp = false
local store = ""
local policeBlip = nil


RegisterNetEvent('krs_shoprobbery:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
end)


RegisterNetEvent('krs_shoprobbery:removeBlip', function()
	RemoveBlip(policeBlip)
end)


RegisterNetEvent('krs_shoprobbery:setBlip', function(position)

	policeBlip = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(policeBlip, 161)
	SetBlipScale(policeBlip, 0.6)
	SetBlipColour(policeBlip, 0)
	PulseBlip(policeBlip)

end)


RegisterNetEvent('krs_shoprobbery:tooFar', function()
	holdingUp, store = false, ''

	lib.notify({
		title = locale('title_notify_robbery'),
		description = locale('description_Robbery_cancelled'),
		type = 'inform'
	})

end)


RegisterNetEvent('krs_shoprobbery:robberyComplete', function(award)
	holdingUp, store = false, ''

	lib.notify({
		title = locale('title_notify_robbery'),
		description = locale('description_money_amount')..award,
		type = 'success'
	})
end)


RegisterNetEvent('krs_shoprobbery:startTimer', function()
    local timer = Config.ShopRobbery[store].tempoRapina

    Citizen.CreateThread(function()
        while timer > 0 and holdingUp do
            Citizen.Wait(1000)

            if timer > 0 then
                timer = timer - 1
            end
        end
        lib.hideTextUI()
    end)

    Citizen.CreateThread(function()
        while holdingUp do
            Citizen.Wait(3)

            if timer > 0 then
                lib.showTextUI(locale('timer_robbery') .. timer .. locale('seconds_robbery'), {
                    position = Config.PositionTexUi,
                    icon = Config.Icon, 
                    style = {
                        borderRadius = Config.borderRadius,
                        backgroundColor = Config.backgroundColor,
                        color = Config.colorText
                    }
                })
            end
        end
    end)
end)


Citizen.CreateThread(function()

    for k, v in pairs(Config.ShopRobbery) do

        local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
        SetBlipSprite(blip, 110)
        SetBlipColour(blip, 0)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(locale('title_blip'))
        EndTextCommandSetBlipName(blip)

    end
end)


for k, v in pairs(Config.ShopRobbery) do
    exports.ox_target:addBoxZone({
        coords = v.position,
        size = vec3(2, 2, 2),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                icon = Config.Icon,
                label = tostring(v.nomeNegozio),
                onSelect = function(data)
                    
                    local playerPed = cache.ped

                    if IsPedArmed(playerPed, 4) then
                        lib.callback('krs_shoprobbery:policeinservice', false, function(policeCount)
                            print(policeCount)

                            if policeCount >= v.poliziotti then
                                local success = lib.skillCheck({'easy', 'easy', { areaSize = 60, speedMultiplier = 2 }, 'easy'}, {'e', 'e', 'e', 'e'})

                                if success then
                                    if lib.progressCircle({
                                        duration = Config.DurationProgressLib,
                                        label = locale('label_progress_lib'),
                                        position = Config.PositionProgress,
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = true
                                        },
                                        anim = {
                                            dict = Config.animDict,
                                            clip = Config.animClip
                                        },
                                    }) then
                                        local playerPos = GetEntityCoords(playerPed)
                                        TriggerServerEvent('krs_shoprobbery:robberyStarted', k, v.poliziotti, GetPlayerJob())
                                        -- dispatch
                                        TriggerServerEvent('notificaspolice')
                                    else
                                        lib.notify({

                                            id = 'some_identifier',
                                            title = locale('title_notify_robbery'),
                                            description = locale('description_minigame'),
                                            position = Config.PositionNotify,
                                            style = {
                                                backgroundColor = Config.backgroundColorNotify,
                                                color = Config.TitleColorNotify,
                                                ['.description'] = {
                                                  color = Config.TextColorNotify
                                                }
                                            },
                                            icon = Config.IconMiniGame, 
                                            iconColor = Config.IconColorMiniGame
                                        })
                                    end
                                else
                                    lib.notify({

                                        id = 'some_identifier',
                                        title = locale('title_notify_robbery'),
                                        description = locale('description_minigame'),
                                        position = Config.PositionNotify,
                                        style = {
                                            backgroundColor = Config.backgroundColorNotify,
                                            color = Config.TitleColorNotify,
                                            ['.description'] = {
                                              color = Config.TextColorNotify
                                            }
                                        },
                                        icon = Config.IconMiniGame, 
                                        iconColor = Config.IconColorMiniGame
                                    })
                                end
                            else
                                lib.notify({

                                    id = 'some_identifier',
                                    title = locale('title_notify_robbery'),
                                    description = locale('description_not_police'),
                                    position = Config.PositionNotify,
                                    style = {
                                        backgroundColor = Config.backgroundColorNotify,
                                        color = Config.TitleColorNotify,
                                        ['.description'] = {
                                          color = Config.TextColorNotify
                                        }
                                    },
                                    icon = Config.IconNotPolice, 
                                    iconColor = Config.IconColorNotPolice
                                })
                            end
                        end)
                    else
                        lib.notify({

                            id = 'some_identifier',
                            title = locale('title_notify_robbery'),
                            description = locale('description_not_gun_robbery'),
                            position = Config.PositionNotify,
                            style = {
                                backgroundColor = Config.backgroundColorNotify,
                                color = Config.TitleColorNotify,
                                ['.description'] = {
                                  color = Config.TextColorNotify
                                }
                            },
                            icon = Config.IconGunRobbery,
                            iconColor = Config.IconColorGunRobbery
                        })
                    end
                end
            }
        }
    })
end

