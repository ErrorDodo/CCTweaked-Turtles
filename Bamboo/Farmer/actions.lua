local state = require("state")
local models = require("models")
local Directions = models.Directions

local function InitTurtle()
    -- Error check the gps location, if it's working assign it to the state
    local x, y, z = gps.locate(2)
    if x == nil then
        print("GPS not working, please check your setup")
        return
    end

    state.InitalLocation = {
        x = x,
        y = y,
        z = z
    }

    -- Get the current blocks around the turtle
    for dir, func in pairs(Directions) do
        state.AreaAround[dir] = CheckFaceForBlock(dir, models)
    end
end

return {
    CheckFaceForBlock = CheckFaceForBlock,
    InitTurtle = InitTurtle,
}
