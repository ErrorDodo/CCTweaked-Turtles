local actions = require("actions")

actions.InitTurtle()

print("Top block is " .. tostring(AreaAround.top.name))
print("Front block is " .. tostring(AreaAround.front.name))
print("Back block is " .. tostring(AreaAround.back.name))
print("Left block is " .. tostring(AreaAround.left.name))
print("Right block is " .. tostring(AreaAround.right.name))