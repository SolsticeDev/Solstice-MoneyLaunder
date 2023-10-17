local QBCore = exports['qb-core']:GetCoreObject()

local pedCoords = { -- Handles Random ped spawning
    {x = 1094.95, y = -321.57, z = 58.36, w = 8.42},
    {x = -1371.07, y = -324.69, z = 38.32, w = 104.74},
    {x = 1696.23, y = 4872.56, z = 41.04, w = 328.97},
    {x = -150.05, y = 6429.43, z = 30.92, w = 46.65},
    {x = 5016.47, y = -5745.76, z = 14.48, w = 149.06},
}

local selectedPedCoord = pedCoords[math.random(1, #pedCoords)]

Citizen.CreateThread(function()
    RequestModel("s_m_m_fiboffice_01") -- Replace all instances of 's_m_m_fiboffice_01' to change ped model
    while not HasModelLoaded("s_m_m_fiboffice_01") do
        Wait(500)
    end

    local ped = CreatePed(4, "s_m_m_fiboffice_01", selectedPedCoord.x, selectedPedCoord.y, selectedPedCoord.z, selectedPedCoord.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['qb-target']:AddBoxZone("MoneyLaunderPed", vector3(selectedPedCoord.x, selectedPedCoord.y, selectedPedCoord.z), 1.5, 2.0, {
        name = "MoneyLaunderPed",
        heading = 155.0,
        debugPoly = false, 
        minZ = selectedPedCoord.z - 1.0,
        maxZ = selectedPedCoord.z + 1.0,
    }, {
        options = {
            {
                type = "client",
                event = "SolsticeMoneyLaunder:Client:openMenu",
                icon = "fas fa-wallet",
                label = "Invest in Business",
            },
            {
                type = "client",
                event = "SolsticeMoneyLaunder:Client:CheckInvestment",
                icon = "fas fa-money-bill-wave",
                label = "Collect Returns",
            }
        },
        distance = 2.5
    })    
end)

RegisterNetEvent('SolsticeMoneyLaunder:Client:CheckInvestment')
AddEventHandler('SolsticeMoneyLaunder:Client:CheckInvestment', function()
    TriggerServerEvent('SolsticeMoneyLaunder:Server:CheckInvestment')
end)

RegisterNetEvent('SolsticeMoneyLaunder:Client:openMenu')
AddEventHandler('SolsticeMoneyLaunder:Client:openMenu', function()
    OpenBusinessSelectionMenu()
end)

function OpenBusinessSelectionMenu()
    exports['qb-menu']:openMenu({
        {
            header = 'Invest in Business',
            icon = 'fas fa-business-time',
            isMenuHeader = true,
        },
        {
            header = 'LTD',
            txt = 'Time: 1 mins | Conversion Rate: 10%', --QB Menu label Visual Change only
            icon = 'fa fa-suitcase',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'LTD',
                    rate = 0.10, --0.85 = 85% Actual conversion Rate EX. If you deposit 1000 you'll get $850 back
                    time = 1 --Wait time in minutes
                }
            }
        },
        {
            header = '24/7',
            txt = 'Time: 10 mins | Conversion Rate: 20%', --QB Menu label Visual Change only
            icon = 'fa fa-suitcase',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = '24/7',
                    rate = 0.20, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 10 --Wait time in minutes
                }
            }
        },
        {
            header = 'LD Organics',
            txt = 'Time: 15 mins | Conversion Rate: 30%', --QB Menu label Visual Change only
            icon = 'fa fa-leaf',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'LD Organics',
                    rate = 0.30, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 15 --Wait time in minutes
                }
            }
        },
        {
            header = 'UWU Cat Cafe',
            txt = 'Time: 20 mins | Conversion Rate: 40%', --QB Menu label Visual Change only
            icon = 'fa fa-paw',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'UWU Cat Cafe',
                    rate = 0.40, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 20 --Wait time in minutes
                }
            }
        },
        {
            header = 'Vanilla Unicorn',
            txt = 'Time: 25 mins | Conversion Rate: 50%', --QB Menu label Visual Change only
            icon = 'fa fa-venus',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'Vanilla Unicorn',
                    rate = 0.50, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 25 --Wait time in minutes
                }
            }
        },
        {
            header = 'Bennys',
            txt = 'Time: 30 mins | Conversion Rate: 60%', --QB Menu label Visual Change only
            icon = 'fa fa-wrench',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'Vanilla Unicorn',
                    rate = 0.60, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 30 --Wait time in minutes
                }
            }
        },
        {
            header = 'PDM',
            txt = 'Time: 35 mins | Conversion Rate: 70%', --QB Menu label Visual Change only
            icon = 'fas fa-car',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'PDM',
                    rate = 0.70, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 35 --Wait time in minutes
                }
            }
        },
        {
            header = 'Pops Pills',
            txt = 'Time: 40 mins | Conversion Rate: 80%', --QB Menu label Visual Change only
            icon = 'fa fa-heartbeat',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'Pops Pills',
                    rate = 0.80, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 40 --Wait time in minutes
                }
            }
        },
        {
            header = 'Diamond Casino',
            txt = 'Time: 45 mins | Conversion Rate: 90%', --QB Menu label Visual Change only
            icon = 'fa fa-diamond',
            params = {
                event = 'SolsticeMoneyLaunder:Client:openAmountInput', --Keep this the same for every buissness
                args = {
                    businessName = 'Diamond Casino',
                    rate = 0.90, --0.90 = 90% Actual conversion Rate EX. If you deposit 1000 you'll get $900 back
                    time = 45 --Wait time in minutes
                }
            }
        },
    })
end

RegisterNetEvent('SolsticeMoneyLaunder:Client:openAmountInput')
AddEventHandler('SolsticeMoneyLaunder:Client:openAmountInput', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Money Laundering",
        submitText = "Submit",
        inputs = {
            {
                text = "Amount of Marked Cash ($)",
                name = "amount",
                type = "number",
                isRequired = true,
            }
        },
    })

    if dialog ~= nil and tonumber(dialog.amount) then
        local amount = tonumber(dialog.amount)
        data.amount = amount
        TriggerServerEvent('SolsticeMoneyLaunder:Server:Invest', data)
    end
end)
