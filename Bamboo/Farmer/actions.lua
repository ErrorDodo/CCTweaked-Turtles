local state = require("state")
local models = require("models")
local Directions = models.Directions

local function detectFrontBlock()
    local hasBlock, blockInfo = turtle.inspect()
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


local function detectUpBlock()
    local hasBlock, blockInfo = turtle.inspectUp()
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

local function detectDownBlock()
    local hasBlock, blockInfo = turtle.inspectDown()
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

local function CheckFaceForBlock(dir)
    local result
    local case = {
        ["front"] = function()
            result = detectFrontBlock()
        end,
        ["top"] = function()
            result = detectUpBlock()
        end,
        ["bottom"] = function()
            result = detectDownBlock()
        end,
        ["back"] = function()
            turtle.turnLeft()
            turtle.turnLeft()
            result = detectFrontBlock()
            turtle.turnLeft()
            turtle.turnLeft()
        end,
        ["left"] = function()
            turtle.turnLeft()
            result = detectFrontBlock()
            turtle.turnRight()
        end,
        ["right"] = function()
            turtle.turnRight()
            result = detectFrontBlock()
            turtle.turnLeft()
        end
    }
    local detectFunc = case[dir]
    if detectFunc then
        detectFunc()
    end
    return {
        name = result.name,
        state = result.state,
        tags = result.tags
    }
end

local function InitTurtle()
    for dir, func in pairs(Directions) do
        state.AreaAround[dir] = CheckFaceForBlock(dir)
    end
end

return {
    CheckFaceForBlock = CheckFaceForBlock,
    InitTurtle = InitTurtle,
}
