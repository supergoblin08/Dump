local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow("Monke Game Gui")
local b = w:CreateFolder("Tools")
local etc = w:CreateFolder("Etc")
b:Toggle("Auto Grab Pistol",function(bool)
    shared.pistol = bool
    print(bool)
end)
b:Toggle("Auto Grab Shotgun",function(bool)
    shared.shot = bool
    print(bool)
end)
b:Label("You will get an item if it is spawned",{
    TextSize = 14;
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(38,38,38);
})
b:Label("Weapons",{
    TextSize = 18;
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(38,38,38);
}) 
b:Button("Katana",function()
for a,b in pairs(game.Workspace:GetChildren()) do
if c.Name == "Katana" and c.FindFirstChild("BillboardGui") == nil then
print("A")
fireclickdetector(workspace.Katana.ClickDetector)
end
end
end)
b:Button("Wrench",function()
for c,d in pairs(game.Workspace:GetChildren()) do
if d.Name == "Wrench" then
local prevpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = d.Position
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = prevpos
fireclickdetector(d.ClickDetector)
end
end
end)
b:Label("Utility",{
    TextSize = 18;
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(38,38,38);
}) 
b:Button("Coffee",function()
fireclickdetector(workspace.CoffeeSpawn.ClickDetector)
end)
b:Button("Toolbox",function()
for a,b in pairs(game.Workspace:GetChildren()) do
if b.Name == "Toolbox" and b:IsA("MeshPart") then
fireclickdetector(b.ClickDetector)
end
end
end)
b:Button("Bandage",function()
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Bandage" and v:IsA("MeshPart") then
fireclickdetector(v.Part2.ClickDetector)
end
end
end)    
etc:Label("Made by _silver#9666",{
    TextSize = 18;
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(38,38,38);
})
etc:Button("Toggle bunker lock",function()
for g,z in pairs(workspace:GetChildren()) do
if z:IsA("Model") and z:FindFirstChild("LightPart") ~= nil and z:FindFirstChild("Lockbutton") ~= nil then
fireclickdetector(z.Lockbutton.ClickDetector)
end
end
end)
etc:DestroyGui()
while wait() do
if shared.pistol == true then
fireclickdetector(game.Workspace.PistolSpawn.ClickDetector)
end
if shared.shot == true and game.Players.LocalPlayer.Backpack:FindFirstChild("Shotgun") == nil then
for y,z in pairs(game.Workspace:GetChildren()) do
if z:IsA("Model") and z:FindFirstChild("Glass") ~= nil and z:FindFirstChild("Handle") ~= nil then
fireclickdetector(z.ClickDetector)
end
end
end
end
