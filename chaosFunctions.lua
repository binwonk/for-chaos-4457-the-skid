local chaosFunctions = {}

local indexHookTable = {}
local namecallHookTable = {}

chaosFunctions.IndexHook = nil;
chaosFunctions.NamecallHook = nil;

local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local LocalPlayer = game:GetService("Players").LocalPlayer

function chaosFunctions.post(url,data,headers) -- string, table, table
    data = game:GetService("HttpService"):JSONEncode(data)
    local stuff = {
        Url = url,
        Body = data,
        Method = "POST",
        Headers = headers
    }
    request(stuff)
end

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

function chaosFunctions.checkHumanoidRootPart(value)
    if value:FindFirstChild("HumanoidRootPart") then
        return true
    else
        return false
    end
end

function chaosFunctions.checkCharFromPlayer(value)
    if value.Character then
        return true
    end
end

function chaosFunctions.getClosestPlayer()
    local Distance = math.huge
	local ClosestPlayer = nil
    if chaosFunctions.checkChar() then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= LocalPlayer and chaosFunctions.checkCharFromPlayer(v) then
                if chaosFunctions.checkHumanoidRootPart(v.Character) then
                    local NewDistance = (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude
                    if NewDistance < Distance then
                        Distance = NewDistance
                        ClosestPlayer = v
                    end
                end
            end
        end
    end
    return ClosestPlayer
end

function chaosFunctions.getClosestCharacter()
    local returnValue = chaosFunctions.getClosestPlayer()
    if returnValue ~= nil then
        return returnValue.Character
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

chaosFunctions.hookTypes = {
    Index = "__index",
    Namecall = "__namecall",
    NewIndex = "__newindex"
}

function chaosFunctions.hook(values)
    values = values or {
        Metamethod = "look like 4 lines up from here retard",
        Target = "instance name (or instance path)",
        Method = "if namecall then put yo thing here (like :Kick for example xdd)",
        Index = "the index yaya",
        Function = "function to return instead of the other thing whatever",
        IgnoreCheckCaller = "true/false" -- NOT AS A STRING
    }
    if values.Metamethod == nil then
        return print("invalid metamethod type... MONKEY!")
    end

    local oldHook = nil;
    oldHook = hookmetamethod(game,tostring(values.Metamethod),function(self,...)
        local args = {...}

        if values.IgnoreCheckCaller and checkcaller() then
            return oldHook(self,...)
        end
        if tostring(self) ~= tostring(values.Target) then
            return oldHook(self,...)
        end
        if values.Metamethod == chaosFunctions.hookTypes.NC and getnamecallmethod() ~= values.Method then
            return oldHook(self,...)
        end
        if values.Metamethod == chaosFunctions.hookTypes.Ind and tostring(args[1]) ~= values.Index then
            return oldHook(self,...)
        end

        return values.Function(oldHook, self, args)
    end)
end

function chaosFunctions.hookFunction(values)
    values = {
        Target = "function path",
        Function = "the hook thing"
    }

    if typeof(values.Target) == "function" and typeof(values.Target) == "function" then
        local old;
        old = hookfunction(values.Target,values.Function)
        return true
    else
        return false
    end
end

function chaosFunctions.toString(yes)
    if typeof(yes) == "string" then
    return yes, "Retard!"
    else
    return tostring(yes), "wow you're not retarded XDDD"
    end
end

function chaosFunctions.concatenate(...)
    args = {...}
    emptyString = ""
    for i,v in pairs(args) do
    string = chaosFunctions.toString(v)
    emptyString = emptyString .. string
    end
    return emptyString
end

function chaosFunctions.getPlayerFromString(string)
    targetplr = nil;
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if (string.sub(string.lower(v.Name), 1, string.len(string))) == string.lower(string) then
            targetplr = v
        elseif (string.sub(string.lower(v.DisplayName), 1, string.len(string))) == string.lower(string) then
            targetplr = v
        end
    end
    if targetplr then
        return targetplr,true
    else
        return false
    end
end

return chaosFunctions
