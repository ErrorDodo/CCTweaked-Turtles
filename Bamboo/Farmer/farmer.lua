local actions = require("actions")
local state = require("state")
local models = require("models")

actions.InitTurtle()

for direction, func in pairs(models.Directions) do
    print("Current " .. direction .. " block is " .. state.AreaAround[direction].name)
end

print("Current X: " .. state.InitalLocation.x .. " Y: " .. state.InitalLocation.y .. " Z: " .. state.InitalLocation.z)
