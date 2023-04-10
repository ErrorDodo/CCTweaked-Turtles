local models = require("models")
BlockData = models.BlockData.new()


IsBusy = false

AreaAround = {
    front = BlockData,
    top = BlockData,
    back = BlockData,
    under = BlockData,
    left = BlockData,
    right = BlockData
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