local state = require("state")
local helpers= require("helpers")

local actions = {}

function actions.InitTurtle()
    state.init()
end

function actions.Move()
    helpers.MoveTo(state.x + 2, state.y + 2, state.z + 2)
    state.update()
end

return actions
