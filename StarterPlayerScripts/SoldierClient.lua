local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local SoldierAI = require(ReplicatedStorage:WaitForChild("NPCModules"):WaitForChild("SoldierAI"))

-- Simple client script to start patrolling after spawn
local waypoints = {
    Vector3.new(20, 5, 20),
    Vector3.new(20, 5, -20),
    Vector3.new(-20, 5, -20),
    Vector3.new(-20, 5, 20),
}

-- Wait for soldiers to appear in the workspace
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
        SoldierAI.patrol(child, waypoints)
    end
end)
