local actions = require("actions")
local state = require("state")
local models = require("models")

actions.InitTurtle()

for direction, _ in pairs(models.Directions) do
    print("Current " .. direction .. " block is " .. state.AreaAround[direction].name)
end

print("Inital Location X: " .. state.InitalLocation.x .. " Y: " .. state.InitalLocation.y .. " Z: " .. state.InitalLocation.z)

actions.Move()
