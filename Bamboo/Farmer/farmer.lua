local actions = require("actions")
local state = require("state")
local models = require("models")

actions.InitTurtle()

for direction, func in pairs(models.Directions) do
    print(direction)
    print(state.AreaAround[direction].name)
end
