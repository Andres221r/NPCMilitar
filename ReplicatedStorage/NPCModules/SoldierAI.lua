local SoldierAI = {}

local PathfindingService = game:GetService("PathfindingService")

-- Configuration table for default soldier stats
SoldierAI.Config = {
    Health = 100,
    Damage = 10,
    SightRange = 100,
    AttackRange = 50,
    WalkSpeed = 16,
}

-- Creates a new soldier NPC model and returns it
function SoldierAI.newSoldier(name, role)
    local character = Instance.new("Model")
    character.Name = name or "Soldier"

    local humanoid = Instance.new("Humanoid")
    humanoid.Health = SoldierAI.Config.Health
    humanoid.WalkSpeed = SoldierAI.Config.WalkSpeed
    humanoid.Parent = character

    local rootPart = Instance.new("Part")
    rootPart.Name = "HumanoidRootPart"
    rootPart.Size = Vector3.new(2,2,1)
    rootPart.Anchored = false
    rootPart.Parent = character

    return character
end

-- Basic AI loop for patrolling between waypoints
function SoldierAI.patrol(soldier, waypoints)
    local humanoid = soldier:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    coroutine.wrap(function()
        while soldier.Parent do
            for _, point in ipairs(waypoints) do
                SoldierAI.moveTo(soldier, point)
                wait(1)
            end
        end
    end)()
end

-- Move the soldier to a target position using pathfinding
function SoldierAI.moveTo(soldier, position)
    local humanoid = soldier:FindFirstChildOfClass("Humanoid")
    local root = soldier:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    local path = PathfindingService:CreatePath()
    path:ComputeAsync(root.Position, position)

    local waypoints = path:GetWaypoints()
    for _, waypoint in ipairs(waypoints) do
        humanoid:MoveTo(waypoint.Position)
        humanoid.MoveToFinished:Wait()
    end
end

return SoldierAI
