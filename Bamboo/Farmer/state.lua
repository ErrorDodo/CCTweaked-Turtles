local models = require("models")
local actions = require("actions")


IsBusy = false

local AreaAround = {
    front = actions.CheckFaceForBlock("front", models),
    top = actions.CheckFaceForBlock("top", models),
    back = actions.CheckFaceForBlock("back", models),
    under = actions.CheckFaceForBlock("under", models),
    left = actions.CheckFaceForBlock("left", models),
    right = actions.CheckFaceForBlock("right", models)
}

InitalLocation = {
    x = 0,
    y = 0,
    z = 0
}

return {
    IsBusy = IsBusy,
    AreaAround = AreaAround,
    InitalLocation = InitalLocation
}