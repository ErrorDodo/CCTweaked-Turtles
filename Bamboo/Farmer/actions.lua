local state = require("state")

local function InitTurtle()
    state.init()
end

return {
    InitTurtle = InitTurtle,
}
