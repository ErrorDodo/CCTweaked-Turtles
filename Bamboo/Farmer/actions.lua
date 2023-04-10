local state = require("state")
local models = require("models")
local Directions = models.Directions

local function DetectBlock(inspectFunc)
    local hasBlock, blockInfo = inspectFunc()
    if hasBlock then
        return {
            name = blockInfo.name,
            state = blockInfo.state,
            tags = blockInfo.tags
        }
    else
        return {
            name = "minecraft:air",
            state = {},
            tags = {}
        }
    end
end


local function CheckFaceForBlock(dir, models)
    local result
    local case = {
        ["front"] = function()
            result = DetectBlock(turtle.inspect)
        end,
        ["top"] = function()
            result = DetectBlock(turtle.inspectUp)
        end,
        ["under"] = function()
            result = DetectBlock(turtle.inspectDown)
        end,
        ["back"] = function()
            turtle.turnLeft()
            turtle.turnLeft()
            result = DetectBlock(turtle.inspect)
            turtle.turnLeft()
            turtle.turnLeft()
        end,
        ["left"] = function()
            turtle.turnLeft()
            result = DetectBlock(turtle.inspect)
            turtle.turnRight()
        end,
        ["right"] = function()
            turtle.turnRight()
            result = DetectBlock(turtle.inspect)
            turtle.turnLeft()
        end
    }
    local detectFunc = case[dir]
    if detectFunc then
        detectFunc()
    end
    return models.BlockData.new {
        name = result.name,
        state = result.state,
        tags = result.tags
    }
end

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
