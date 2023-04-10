local state = require("state")

local actions = {}

function actions.InitTurtle()
    state.init()
end

return actions
