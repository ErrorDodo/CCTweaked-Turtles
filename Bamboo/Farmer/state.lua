local models = require("models")
local helpers = require("helpers")


IsBusy = false

local AreaAround = {
    front = helpers.CheckFaceForBlock("front", models),
    top = helpers.CheckFaceForBlock("top", models),
    back = helpers.CheckFaceForBlock("back", models),
    under = helpers.CheckFaceForBlock("under", models),
    left = helpers.CheckFaceForBlock("left", models),
    right = helpers.CheckFaceForBlock("right", models)
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