-- To use function CheckFaceForBlock("front")
function CheckFaceForBlock(dir)
    local result
    local case = {
        ["front"] = function()
            has_block, result = turtle.inspect()
            if not has_block then
                result = {
                    name = "minecraft:air",
                    state = {},
                    tags = {}
                }
            end
        end,
        ["top"] = function()
            has_block, result = turtle.inspectUp()
            if not has_block then
                result = {
                    name = "minecraft:air",
                    state = {},
                    tags = {}
                }
            end
        end,
        ["back"] = function()
            has_block, result = turtle.inspectDown()
            if not has_block then
                result = {
                    name = "minecraft:air",
                    state = {},
                    tags = {}
                }
            end
        end,
        ["left"] = function()
            turtle.turnLeft()
            has_block, result = turtle.inspect()
            if not has_block then
                result = {
                    name = "minecraft:air",
                    state = {},
                    tags = {}
                }
            end
            turtle.turnRight()
        end,
        ["right"] = function()
            turtle.turnRight()
            has_block, result = turtle.inspect()
            if not has_block then
                result = {
                    name = "minecraft:air",
                    state = {},
                    tags = {}
                }
            end
            turtle.turnLeft()
        end
    }
    local detectFunc = case[dir]
    if detectFunc then
        detectFunc()
    end
    return result {
        name = result.name,
        state = result.state,
        tags = result.tags
    }
end

-- To use function Move("forward", 2)
function Move(dir, numBlocks)
    numBlocks = numBlocks or 1
    local result
    local case = {
        ["forward"] = function() result = turtle.forward() end,
        ["up"] = function() result = turtle.up() end,
        ["back"] = function() result = turtle.back() end,
        ["down"] = function() result = turtle.down() end,
        ["left"] = function()
            turtle.turnLeft()
            result = turtle.forward()
        end,
        ["right"] = function()
            turtle.turnRight()
            result = turtle.forward()
        end
    }
    local moveFunc = case[dir]
    if moveFunc then
        for i = 1, numBlocks do
            moveFunc()
            if not result then
                break
            end
        end
    end
    return result
end

function CalibrateArea()
    -- Check the area around the turtle
    for dir, func in pairs(Directions) do
        AreaAround[dir] = CheckFaceForBlock(dir)
    end
end
