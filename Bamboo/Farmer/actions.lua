local state = require("state")
local helpers= require("helpers")

local actions = {}

function actions.InitTurtle()
    state.init()
end

function actions.Move()
    helpers.MoveTo(state.CurrentLocation.x + 2, state.CurrentLocation.y + 2, state.CurrentLocation.z + 2)
    state.update()
end

return actions
