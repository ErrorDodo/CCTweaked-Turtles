local models = require("models")
local helpers = require("helpers")

local state = {}

state.IsBusy = false

state.AreaAround = {
    front = nil,
    top = nil,
    back = nil,
    under = nil,
    left = nil,
    right = nil
}

state.InitalLocation = {
    x = 0,
    y = 0,
    z = 0
}

function state.init()
    local x, y, z = gps.locate(2)
    if x == nil then
        print("GPS not working, please check your setup")
        return
    end

    state.InitialLocation = {
        x = x,
        y = y,
        z = z
    }

    for direction, _ in pairs(models.Directions) do
        state.AreaAround[direction] = helpers.CheckFaceForBlock(direction, models)
    end
end


function state.update()
    -- Update the state AreaAround
    for direction, _ in pairs(models.Directions) do
        state.AreaAround[direction] = helpers.CheckFaceForBlock(direction, models)
    end
end

return models