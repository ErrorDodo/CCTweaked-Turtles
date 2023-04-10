local model = {}

model.Directions = {
    front = function()
    end,
    top = function()
    end,
    back = function()
    end,
    under = function()
    end,
    left = function()
    end,
    right = function()
    end
}

model.AreaMap = {}
model.AreaMap.__index = model.AreaMap

function model.AreaMap.new()
    local self = setmetatable({}, model.AreaMap)
    self.SubAreas = {}
    return self
end

model.SubArea = {}
model.SubArea.__index = model.SubArea

function model.SubArea.new()
    local self = setmetatable({}, model.SubArea)
    self.X = 0.0
    self.Y = 0.0
    self.Z = 0.0
    self.Blocks = {}
    return self
end

model.Blocks = {}
model.Blocks.__index = model.Blocks

function model.Blocks.new()
    local self = setmetatable({}, model.Blocks)
    self.X = 0
    self.Y = 0
    self.Z = 0
    self.BlockData = {}
    return self
end

model.BlockData = {}
model.BlockData.__index = model.BlockData

function model.BlockData.new()
    local self = setmetatable({}, model.BlockData)
    self.name = ""
    self.state = {}
    self.tags = {}
    return self
end

return model
