local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoldierAI = require(ReplicatedStorage:WaitForChild("NPCModules"):WaitForChild("SoldierAI"))

-- Example spawn points for demonstration
local spawnPoints = {
    Vector3.new(0, 5, 0),
    Vector3.new(10, 5, 0),
    Vector3.new(-10, 5, 0),
}

-- Spawns a squad of soldiers at the given spawn points
local function spawnSquad()
    for i, pos in ipairs(spawnPoints) do
        local soldier = SoldierAI.newSoldier("Soldier" .. i)
        soldier.Parent = workspace
        soldier:SetPrimaryPartCFrame(CFrame.new(pos))
    end
end

spawnSquad()
