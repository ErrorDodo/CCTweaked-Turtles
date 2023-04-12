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
    return result
end

function helpers.MoveTo(x, y, z)
    local currentX, currentY, currentZ = gps.locate()
    local xDiff = x - currentX
    local yDiff = y - currentY
    local zDiff = z - currentZ

    if xDiff > 0 then
        turtle.turnRight()
        for i = 1, xDiff do
            helpers.CheckFuel()
            -- check if block is infront of turtle
            local block = helpers.CheckFaceForBlock("front", models)
            if block.name ~= "minecraft:air" then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnLeft()
    elseif xDiff < 0 then
        turtle.turnLeft()
        helpers.CheckFuel()
        for i = 1, math.abs(xDiff) do
            local block = helpers.CheckFaceForBlock("front", models)
            if block.name ~= "minecraft:air" then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnRight()
    end

    if yDiff > 0 then
        for i = 1, yDiff do
            helpers.CheckFuel()
            local block = helpers.CheckFaceForBlock("top", models)
            if block.name ~= "minecraft:air" then
                turtle.digUp()
            end
            turtle.up()
        end
    elseif yDiff < 0 then
        for i = 1, math.abs(yDiff) do
            helpers.CheckFuel()
            local block = helpers.CheckFaceForBlock("under", models)
            if block.name ~= "minecraft:air" then
                turtle.digDown()
            end
            turtle.down()
        end
    end

    if zDiff > 0 then
        turtle.turnLeft()
        turtle.turnLeft()
        for i = 1, zDiff do
            helpers.CheckFuel()
            local block = helpers.CheckFaceForBlock("front", models)
            if block.name ~= "minecraft:air" then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnRight()
        turtle.turnRight()
    elseif zDiff < 0 then
        for i = 1, math.abs(zDiff) do
            helpers.CheckFuel()
            local block = helpers.CheckFaceForBlock("front", models)
            if block.name ~= "minecraft:air" then
                turtle.dig()
            end
            turtle.forward()
        end
    end
end

function helpers.CheckFuel()
    local maxFuelLevel = turtle.getFuelLimit()
    local fuelLevel = turtle.getFuelLevel()
    local fuelPercent = (fuelLevel / maxFuelLevel) * 100
    local fuelDiff = maxFuelLevel - fuelLevel

    if fuelPercent < 10 then
        for i = 1, 16 do
            local item = turtle.getItemDetail(i)
            if item.name == "minecraft:coal" then
                turtle.select(i)
                local tryRefuel = turtle.refuel(fuelDiff - 4)
                local newFuelLevel = turtle.getFuelLevel()

                if not tryRefuel and newFuelLevel == fuelLevel then
                    print("Assuming not alot of coal left to use, will use remaining coal to refuel")
                    turtle.refuel()
                end
            end
        end
    end
end

function helpers.GetCurrentLocation()
    return gps.locate()
end

return helpers
