--Only change notifications and item in here unless you know what your doing

local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('SolsticeMoneyLaunder:Server:Invest')
AddEventHandler('SolsticeMoneyLaunder:Server:Invest', function(data)
    local src = source
    local businessName = data.businessName
    local rate = data.rate
    local time = data.time
    local amount = data.amount

    local xPlayer = QBCore.Functions.GetPlayer(src)
    local markedCash = xPlayer.Functions.GetItemByName("markedcash")

    if markedCash and markedCash.amount >= amount then
        local convertedAmount = math.floor(amount * rate)

        xPlayer.Functions.RemoveItem("markedcash", amount)
        
        TriggerClientEvent('QBCore:Notify', src, "You've invested " .. amount .. " marked cash in " .. businessName .. ". Please wait for " .. time .. " minutes.", 'success', 2000)
        
        local query = 'INSERT INTO investments (identifier, businessName, amountInvested, convertedAmount, endTime) VALUES (?, ?, ?, ?, DATE_ADD(NOW(), INTERVAL ? MINUTE))'
        local parameters = {
            [1] = xPlayer.PlayerData.citizenid, 
            [2] = businessName, 
            [3] = amount, 
            [4] = convertedAmount, 
            [5] = time 
        }
        exports.oxmysql:insert(query, parameters, function(insertId)
            if insertId then
            else
                print("Failed to insert investment record.")
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough marked cash!", 'error', 2000)
    end
end)

RegisterServerEvent('SolsticeMoneyLaunder:Server:CheckInvestment')
AddEventHandler('SolsticeMoneyLaunder:Server:CheckInvestment', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    local maturedQuery = 'SELECT convertedAmount FROM investments WHERE identifier = ? AND endTime <= NOW() LIMIT 1'
    local parameters = { [1] = xPlayer.PlayerData.citizenid }

    exports.oxmysql:execute(maturedQuery, parameters, function(result)
        if result and #result > 0 then
            local amount = result[1].convertedAmount

            xPlayer.Functions.AddMoney('cash', amount)

            local deleteQuery = 'DELETE FROM investments WHERE identifier = ? AND endTime <= NOW() LIMIT 1'
            exports.oxmysql:execute(deleteQuery, parameters)

            TriggerClientEvent('QBCore:Notify', src, "You've collected " .. amount .. " washed money.", 'success', 2000)
        else
            local ongoingQuery = 'SELECT * FROM investments WHERE identifier = ? AND endTime > NOW() LIMIT 1'
            exports.oxmysql:execute(ongoingQuery, parameters, function(ongoingResult)
                if ongoingResult and #ongoingResult > 0 then
                    TriggerClientEvent('QBCore:Notify', src, "Your investment hasn't matured yet.", 'error', 2000)
                else
                    TriggerClientEvent('QBCore:Notify', src, "You have no active investments.", 'error', 2000)
                end
            end)
        end
    end)
end)