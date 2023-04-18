local chaosFunctions = {}

function chaosFunctions.convertToCFrame(value)
if typeof(value) == "Vector3" then
returnValue = CFrame.new(value)
return returnValue
end
end

function chaosFunctions.checkChar()
if game:GetService("Players").LocalPlayer.Character then
return true
else
return false
end
end

function chaosFunctions.getRootPart()
if not game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("RootPart"):Wait()
end
return game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart
end

function chaosFunctions.teleport(value)
print(typeof(value))
local CFramePos = nil;
if typeof(value) == "Vector3" then
CFramePos = chaosFunctions.convertToCFrame(value)
elseif typeof(value) == "CFrame" then
CFramePos = value
end
if chaosFunctions.checkChar() then
chaosFunctions.getRootPart().CFrame = CFramePos
return "Success!"
end
end

return chaosFunctions
