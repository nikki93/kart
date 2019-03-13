local cs = require 'share.cs'
local server = cs.server

if USE_CASTLE_CONFIG then
    server.useCastleConfig()
else
    server.enabled = true
    server.start('22122') -- Port of server
end

local share = server.share -- Maps to `client.share` -- can write
local homes = server.homes -- `homes[id]` maps to `client.home` for that `id` -- can read

local gameState = ACTUAL_GAME and "intro" or "running"
local startTime = nil
local winner = nil
local bananas = {}

function server.connect(id) -- Called on connect from client with `id`
    print('client ' .. id .. ' connected')
end

function server.disconnect(id) -- Called on disconnect from client with `id`
    print('client ' .. id .. ' disconnected')
    share.cars[id] = nil
end

function server.receive(id, ...) -- Called when client with `id` does `client.send(...)`
end

-- Server only gets `.load`, `.update`, `.quit` Love events (also `.lowmemory` and `.threaderror`
-- which are less commonly used)

function server.load()
    share.cars = {}
end

function server.update(dt)
    if gameState == "intro" and startTime and os.time() >= startTime then
        gameState = "countdown"
        startTime = os.time() + 4
    end

    if gameState == "countdown" and startTime and os.time() >= startTime then
        gameState = "running"
        startTime = nil
        bananas = {}
    end

    if gameState == "postgame" and startTime and os.time() >= startTime then
        gameState = "intro"
        startTime = nil
    end

    local isRequestingStart = false
    local takenItems = {}
    local switchItemUsers = {}
    local dizzyItemUsers = {}

    for id, home in pairs(server.homes) do -- Combine mouse info from clients into share
        if home.car then
            share.cars[id] = home.car
        end

        if home.requestingStart then
            isRequestingStart = true
        end

        if home.takenItem then
            takenItems[home.takenItem] = true
        end

        if home.isFinished and gameState == "running" then
            gameState = "postgame"
            winner = id
            startTime = os.time() + 8
        end

        if home.switchItemEnabled then
            switchItemUsers[id] = true
        end

        if home.dizzyItemEnabled then
            dizzyItemUsers[id] = true
        end

        if home.addBanana then
            table.insert(bananas, home.addBanana)
        end

        if home.removeBanana then
            for k,v in pairs(bananas) do
                if v.id == home.removeBanana then
                    table.remove(bananas, k)
                    break
                end
            end
        end
    end

    share.gameState = gameState
    share.isRequestingStart = startTime and isRequestingStart
    share.takenItems = takenItems
    share.winner = winner
    share.switchItemUsers = switchItemUsers
    share.dizzyItemUsers = dizzyItemUsers
    share.bananas = bananas

    if isRequestingStart == true and gameState == "intro" and not startTime then
        -- wait 3 seconds
        startTime = os.time() + 2
    end

    if isRequestingStart == false and gameState == "intro" then
        startTime = nil
    end
end