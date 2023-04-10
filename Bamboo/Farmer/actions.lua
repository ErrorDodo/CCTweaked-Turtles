local state = require("state")

-- To use function CheckFaceForBlock("front")
function CheckFaceForBlock(dir)
    local result
    local case = {
        ["front"] = function()
            state.IsBusy = true
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
            state.IsBusy = true
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
            state.IsBusy = true
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
            state.IsBusy = true
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
            state.IsBusy = true
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
    state.IsBusy = false
    return result {
        name = result.name,
        state = result.state,
        tags = result.tags
    } or {
        name = "minecraft:air",
        state = {},
        tags = {}
    }
end

-- To use function Move("forward", 2)
function Move(dir, numBlocks)
    numBlocks = numBlocks or 1
    local result
    local case = {
        ["forward"] = function() state.IsBusy = true result = turtle.forward() end,
        ["up"] = function() state.IsBusy = true result = turtle.up() end,
        ["up"] = function() state.IsBusy = true result = turtle.up() end,
        ["up"] = function() state.IsBusy = true result = turtle.up() end,
        ["back"] = function() state.IsBusy = true result = turtle.back() end,
        ["down"] = function() state.IsBusy = true result = turtle.down() end,
        ["left"] = function()
            state.IsBusy = true
            turtle.turnLeft()
            result = turtle.forward()
        end,
        ["right"] = function()
            state.IsBusy = true
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
    state.IsBusy = false
    return result
end

function InitTurtle()
    -- Check the area around the turtle
    for dir, func in pairs(Directions) do
        state.AreaAround[dir] = CheckFaceForBlock(dir)
    end
end

return {
    CheckFaceForBlock = CheckFaceForBlock,
    Move = Move,
    InitTurtle = InitTurtle
}
