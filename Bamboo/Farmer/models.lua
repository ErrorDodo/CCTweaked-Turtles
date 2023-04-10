local models = {}

models.Directions = {
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

local AreaMap = {}
models.AreaMap.__index = AreaMap

function models.AreaMap.new()
    local self = setmetatable({}, AreaMap)
    self.SubAreas = {}
    return self
end

local SubArea = {}
models.SubArea.__index = SubArea

function models.SubArea.new()
    local self = setmetatable({}, SubArea)
    self.X = 0.0
    self.Y = 0.0
    self.Z = 0.0
    self.Blocks = {}
    return self
end

local Blocks = {}
models.Blocks.__index = Blocks

function models.Blocks.new()
    local self = setmetatable({}, Blocks)
    self.X = 0
    self.Y = 0
    self.Z = 0
    self.BlockData = {}
    return self
end

local BlockData = {}
models.BlockData.__index = BlockData

function models.BlockData.new()
    local self = setmetatable({}, BlockData)
    self.name = ""
    self.state = {}
    self.tags = {}
    return self
end

return models