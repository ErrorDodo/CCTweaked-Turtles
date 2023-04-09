Directions = {
    front = function() end,
    top = function() end,
    back = function() end,
    left = function() end,
    right = function() end
}

-- To use function CheckFaceForBlock("front")
function CheckFaceForBlock(dir)
    local result
    case = {
      ["front"] = function() result = turtle.detect() end,
      ["top"] = function() result = turtle.detectUp() end,
      ["back"] = function() result = turtle.detectDown() end,
      -- Add these as false because I don't really want to lose track of the facing direction
      -- (Add them back when state is implemented)
      ["left"] = function()
        result = false
      end,
      ["right"] = function()
        result = false
      end
    }
    local detectFunc = case[dir]
    if detectFunc then
      detectFunc()
    end
    return result or false
end

-- To use function Move("forward", 2)
function Move(dir, numBlocks)
    numBlocks = numBlocks or 1
    local result
    case = {
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
        for i=1,numBlocks do
            moveFunc()
            if not result then
                break
            end
        end
    end
    return result
end
