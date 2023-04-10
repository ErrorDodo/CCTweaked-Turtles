Directions = {
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
AreaMap.__index = AreaMap

function AreaMap.new()
    local self = setmetatable({}, AreaMap)
    self.SubAreas = {}
    return self
end

local SubArea = {}
SubArea.__index = SubArea

function SubArea.new()
    local self = setmetatable({}, SubArea)
    self.X = 0.0
    self.Y = 0.0
    self.Z = 0.0
    self.Blocks = {}
    return self
end

local Blocks = {}
Blocks.__index = Blocks

function Blocks.new()
    local self = setmetatable({}, Blocks)
    self.X = 0
    self.Y = 0
    self.Z = 0
    self.BlockData = {}
    return self
end

local BlockData = {}
BlockData.__index = BlockData

function BlockData.new()
    local self = setmetatable({}, BlockData)
    self.name = ""
    self.states = {}
    self.tags = {}
    return self
end

return {
    Directions = Directions,
    AreaMap = AreaMap,
    SubArea = SubArea,
    Blocks = Blocks,
    BlockData = BlockData,
}