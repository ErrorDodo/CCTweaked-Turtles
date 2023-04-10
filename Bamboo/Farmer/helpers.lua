local models = require("models")

local helpers = {}

function helpers.DetectBlock(inspectFunc)
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

function helpers.CheckFaceForBlock(dir, models)
    local result
    local case = {
        ["front"] = function()
            result = helpers.DetectBlock(turtle.inspect)
        end,
        ["top"] = function()
            result = helpers.DetectBlock(turtle.inspectUp)
        end,
        ["under"] = function()
            result = helpers.DetectBlock(turtle.inspectDown)
        end,
        ["back"] = function()
            turtle.turnLeft()
            turtle.turnLeft()
            result = helpers.DetectBlock(turtle.inspect)
            turtle.turnLeft()
            turtle.turnLeft()
        end,
        ["left"] = function()
            turtle.turnLeft()
            result = helpers.DetectBlock(turtle.inspect)
            turtle.turnRight()
        end,
        ["right"] = function()
            turtle.turnRight()
            result = helpers.DetectBlock(turtle.inspect)
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

return helpers
