local state = require("state")
local models = require("models")
local Directions = models.Directions
local BlockData = models.BlockData

local function GetBlockData()
    local success, blockData = turtle.inspect()
    if success then
        return blockData
    else
        return {
            name = "minecraft:air",
            state = {},
            tags = {}
        }
    end
end

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
            result = GetBlockData()
        end,
        ["top"] = function()
            turtle.digUp()
            result = GetBlockData()
        end,
        ["back"] = function()
            turtle.turnLeft()
            turtle.turnLeft()
            result = GetBlockData()
            turtle.turnLeft()
            turtle.turnLeft()
        end,
        ["left"] = function()
            turtle.turnLeft()
            result = GetBlockData()
            turtle.turnRight()
        end,
        ["right"] = function()
            turtle.turnRight()
            result = GetBlockData()
            turtle.turnLeft()
        end
    }
    local detectFunc = case[dir]
    if detectFunc then
        detectFunc()
    end
    return BlockData {
        name = result.name,
        state = result.state,
        tags = result.tags
    }
end

local function CalibrateArea(xSize, ySize, zSize)
    local startX, startY, startZ = gps.locate()
    local subAreaSize = 10 -- adjust this to change the size of the sub-areas

    local blocks = {}
    local function updateBlock(x, y, z, blockData)
        local key = string.format("%d:%d:%d", x, y, z)
        local existingData = blocks[key]
        if existingData == nil or existingData.name ~= blockData.name or existingData.state ~= blockData.state or existingData.tags ~= blockData.tags then
            blocks[key] = blockData
        end
    end

    local function checkSubArea(xMin, xMax, yMin, yMax, zMin, zMax)
        for x = xMin, xMax do
            for z = zMin, zMax do
                turtle.moveTo(x, yMin, z)
                updateBlock(x, yMin, z, CheckFaceForBlock("front"))
                turtle.moveTo(x, yMax, z)
                updateBlock(x, yMax, z, CheckFaceForBlock("back"))
            end
        end

        for y = yMin, yMax do
            for z = zMin, zMax do
                turtle.moveTo(xMin, y, z)
                updateBlock(xMin, y, z, CheckFaceForBlock("left"))
                turtle.moveTo(xMax, y, z)
                updateBlock(xMax, y, z, CheckFaceForBlock("right"))
            end
        end

        for x = xMin, xMax do
            for y = yMin, yMax do
                turtle.moveTo(x, y, zMin)
                updateBlock(x, y, zMin, CheckFaceForBlock("top"))
                turtle.moveTo(x, y, zMax)
                updateBlock(x, y, zMax, CheckFaceForBlock("down"))
            end
        end
    end

    local xSubAreas = math.ceil(xSize / subAreaSize)
    local ySubAreas = math.ceil(ySize / subAreaSize)
    local zSubAreas = math.ceil(zSize / subAreaSize)

    for x = 1, xSubAreas do
        local xMin = startX + (x - 1) * subAreaSize
        local xMax = math.min(startX + x * subAreaSize - 1, startX + xSize - 1)
        for y = 1, ySubAreas do
            local yMin = startY + (y - 1) * subAreaSize
            local yMax = math.min(startY + y * subAreaSize - 1, startY + ySize - 1)
            for z = 1, zSubAreas do
                local zMin = startZ + (z - 1) * subAreaSize
                local zMax = math.min(startZ + z * subAreaSize - 1, startZ + zSize - 1)
                checkSubArea(xMin, xMax, yMin, yMax, zMin, zMax)
            end
        end
    end

    return blocks
end


local function InitTurtle()
    -- Set the turtle to be busy so no other actions can be taken
    state.IsBusy = true
    -- Check the area around the turtle
    CalibrateArea(20, 20, 20)
end

return {
    CheckFaceForBlock = CheckFaceForBlock,
    InitTurtle = InitTurtle,
    DetectUpBlock = detectUpBlock,
    DetectDownBlock = detectDownBlock,
    DetectFrontBlock = detectFrontBlock
}
