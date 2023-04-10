local models = require("models")
local helpers = require("helpers")


IsBusy = false

AreaAround = {
    front = nil,
    top = nil,
    back = nil,
    under = nil,
    left = nil,
    right = nil
}

InitalLocation = {
    x = 0,
    y = 0,
    z = 0
}

local function init()
    local x, y, z = gps.locate(2)
    if x == nil then
        print("GPS not working, please check your setup")
        return
    end

    InitalLocation = {
        x = x,
        y = y,
        z = z
    }

    for direction, _ in pairs(models.Directions) do
        AreaAround[direction] = helpers.CheckFaceForBlock(direction, models)
    end
end

local function update()
    -- Update the state AreaAround
    for direction, _ in pairs(models.Directions) do
        AreaAround[direction] = helpers.CheckFaceForBlock(direction, models)
    end
end

return {
    IsBusy = IsBusy,
    InitalLocation = InitalLocation,
    AreaAround = AreaAround,
    update = update,
    init = init
}