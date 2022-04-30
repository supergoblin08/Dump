local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Player = game.Players.LocalPlayer
local Players = game.Players
local AuraDist = 5
local Barbarians = Workspace:WaitForChild("Barbarians")
local Karts = Workspace:WaitForChild("Karts")
local Houses = Workspace:WaitForChild("Houses")
local Stores = Workspace:WaitForChild("Stores")
local Peels = Workspace:WaitForChild("BananaPeels")
local Harvest = {
    Rice = Workspace:WaitForChild("Rice"),
    Trees = Workspace:WaitForChild("Trees")
}

while game:IsLoaded() == false do
    wait()
end

function Touch(Part, Touching)
    pcall(function()
        firetouchinterest(Part, Touching, 0)
        firetouchinterest(Part, Touching, 1)
    end)
end

function GetTool(Name)
    local Tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
    if Tool and Tool:FindFirstChild("Handle") and Tool.Name:find(Name) then
        return Tool
    end
    return false
end

function GetHarvestable(Handle, Crop)
    local Closest = false
    local Distance = AuraDist
    for _, A_1 in next, Harvest[Crop]:GetChildren() do
        local Middle = A_1:FindFirstChild("Middle", true)
        if Middle and A_1:FindFirstChild("Health") and A_1.Health.Value > 0 then
            local Dist = (Handle.Position - Middle.Position).magnitude
            if Dist < Distance then
                Distance = Dist
                Closest = Middle
            end
        end
    end
    return Closest
end

function GetClosestStructure(Handle)
    local Distance = AuraDist
    local Pos = Handle.Position
    -- Houses
    for _, A_1 in next, Houses:GetChildren() do
        if A_1:IsA("Model") and A_1.PrimaryPart and (Pos - A_1.PrimaryPart.Position).magnitude <= Distance + 6 then
            return A_1.PrimaryPart
        end
    end
    -- Stores
    for _, A_1 in next, Stores:GetChildren() do
        local Break = A_1:FindFirstChild("Breakable")
        if Break and (Pos - Break.Position).magnitude <= Distance + 2 then
            return Break
        end
    end
    -- Gate
    local Door = Workspace:WaitForChild("Gate").Door
    if (Pos - Door.Position).magnitude <= Distance - 1 then
        return Door
    end
    -- Prison
    local Prison = Workspace:WaitForChild("JailGate").FrontDoor.Breakable
    if (Pos - Prison.Position).magnitude <= Distance - 2 then
        return Prison
    end
    return false
end



local X = Material.Load({
    Title = "hub, made by _silver#9666",
    Style = 3,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark",
})

local Y = X.New({
    Title = "Auras"
})

local C = Y.Slider({
    Text = "Aura Distance",
    Callback = function(Value)
        AuraDist = Value
    end,
    Min = 1,
    Max = 40,
    Def = 5
})

local E = Y.ChipSet({
    Text = "Tool auras",
    Callback = function(ChipSet)
        table.foreach(ChipSet, function(Option, Value)
            if Option == "Hammer Aura" then
				task.spawn(function()
					while Value == true do
            			local Hammer = GetTool("Hammer")
            			if Hammer then
                			local Building = GetClosestStructure(Hammer.Handle)
                			if Building ~= false then
                    			Hammer:Activate()
                    			Touch(Hammer.Handle, Building)
                			end
            			end	
						task.wait()
       				end
				end)
			elseif Option == "Sickle Aura" then
				task.spawn(function()
					while Value == true do
            			-- Variables
            			local Kart = Karts:FindFirstChild(Player.Name)
            			local Seat = Kart and Kart:FindFirstChild("VehicleSeat")
            			local Sickle = GetTool("Sickle")
            			-- Vehicle
            			if Seat and Kart:FindFirstChild("RightSickle") and Kart:FindFirstChild("LeftSickle") then
                			local Rice_To_Cut = GetHarvestable(Kart:FindFirstChild("RightSickle"), "Rice")
		                	if Rice_To_Cut ~= false then
        		            	Touch(Kart.RightSickle, Rice_To_Cut)
                		    	Touch(Kart.LeftSickle, Rice_To_Cut)
                			end
            			-- Sickle
            			elseif Sickle then
               				local Rice_To_Cut = GetHarvestable(Sickle.Handle, "Rice")
                			if Rice_To_Cut ~= false then
                    			Sickle:Activate()
                    			Touch(Sickle.Handle, Rice_To_Cut)
                    			Touch(Sickle.Handle, Rice_To_Cut)
                			end
            			end
            			task.wait()
        			end
				end)
			elseif Option == "Axe Aura" then
				task.spawn(function()
					while Value == true do
            			local Axe = GetTool("Axe")
            			if Axe then
                			local Tree = GetHarvestable(Axe.Handle, "Trees")
                			if Tree ~= false then
                    			Axe:Activate()
                    			Touch(Axe.Handle, Tree)
                			end
            			end
            			task.wait(0.1)
					end
				end)
			end
        end)
    end,
    Options = {
        ["Hammer Aura"] = false,
        ["Axe Aura"] = false,
        ["Sickle Aura"] = false
    }
})

Y.Toggle({
    Text = "Arrest Aura [Guards Only]",
    Callback = function(value)
        task.spawn(function()
			while value == true do
            	local Distance = 13
            	local Arrest_Tool = GetTool("Handcuffs")
            	if Arrest_Tool then
                	for _, A_1 in next, Players:GetPlayers() do
                    	local Stats = A_1:FindFirstChild("stats")
                    	local Char = A_1.Character
                    	if A_1 ~= Player and Stats and Char and Char.PrimaryPart and Stats:FindFirstChild("Arrestable") and Stats.Arrestable.Value == true and Player:DistanceFromCharacter(Char.PrimaryPart.Position) <= Distance then
                        	Arrest_Tool:Activate()
                        	Touch(Arrest_Tool.Handle, Char.PrimaryPart)
                    	end
                	end
            	end
            	task.wait(0.1)
        	end
		end)
    end,
    Enabled = false
})


