-- Register the Black Hole Whip Object
local BlackHoleWhip = {
    name = "Event Horizon",
    damage = 110,
    damageType = "Summon",       -- Classifies it as a summoner weapon
    width = 30,
    height = 30,
    useTime = 30,
    useAnimation = 30,
    useStyle = 1,                -- Whip swinging attack animation
    knockBack = 2,
    autoReuse = true,
    rare = 10,                   -- Red rarity tier
    shoot = 841,                 -- Uses baseline whip projectile structure
    shootSpeed = 4,              -- Speed modifier for the swing range
}

-- Trigger event when the whip segment touches an NPC
function BlackHoleWhip:OnHitNPC(player, npc, damage, knockback, crit)
    -- Step 1: Inflict Summoner Tag damage bonus if desired
    npc:AddBuff(310, 240) -- Applies standard whip tag (increases minion targeting priority)

    -- Step 2: Spawn the Black Hole at the enemy's exact coordinates
    local spawnX = npc.position.X
    local spawnY = npc.position.Y
    
    -- ID 707 is the Void Vortex / Black Hole graphic style projectile
    -- player.whoAmI registers the ownership back to your character
    local blackHole = Projectile:NewProjectile(spawnX, spawnY, 0, 0, 707, damage * 1.5, 0, player.whoAmI)
    
    -- Step 3: Implement the "Stuck" mechanic using a looping hook
    -- We force the enemy velocity to 0 and pull adjacent enemies in
    LuAria:CreateTimer(function()
        -- Lock target enemy position
        npc.velocity.X = 0
        npc.velocity.Y = 0
        
        -- Optional: Visual particle indicator around the trapped target
        Dust:NewDust(npc.position, npc.width, npc.height, 62, 0, 0, 100, "Purple", 1.5)
    end, 60) -- Loops/runs behavior for 60 frames (1 full second)
end

return BlackHoleWhip
