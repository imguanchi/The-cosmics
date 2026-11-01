local BlackHoleStaff = {
    name = "BlackHoleW Staff",
    texture = "staff.png",         -- References your uploaded staff image
    damage = 135,
    damageType = "Magic",          -- Magic class type
    mana = 12,                     -- Consumes 12 mana per cast
    width = 50,
    height = 50,
    useTime = 20,                  -- Fast firing rate
    useAnimation = 20,
    useStyle = 5,                  -- Holding staff animation
    knockBack = 4,
    rare = 11,                     -- Purple rarity tier
    autoReuse = true,
    
    -- Mechanical projectile behaviors
    shoot = 658,                   -- Baseline Projectile ID (Shadow Flame bolt archetype)
    shootSpeed = 16,               -- High firing velocity
}

function BlackHoleStaff:Shoot(player, position, velocity, type, damage, knockback)
    -- Step 1: Force projectile to render black shadow particles as it travels
    local proj = Projectile:NewProjectile(position.X, position.Y, velocity.X, velocity.Y, type, damage, knockback, player.whoAmI)
    
    LuAria:CreateTimer(function()
        if proj.active then
            -- Spawns custom heavy black particle clusters along the flight trail
            Dust:NewDust(proj.position, proj.width, proj.height, 62, 0, 0, 150, "Black", 2.0)
        end
    end, -1) -- Loops continuously for the entire life of the bolt
    
    return false -- Overrides default firing behavior to activate our custom script tracking
end

-- Step 2: Trigger Splashing Black Hole Explosion on enemy contact
function BlackHoleStaff:OnHitNPC(player, npc, damage, knockback, crit)
    local explodeX = npc.position.X
    local explodeY = npc.position.Y
    
    -- Triggers a massive continuous AoE splash detonation (Void Blast ID 707)
    local splashExplosion = Projectile:NewProjectile(explodeX, explodeY, 0, 0, 707, damage * 2, 8, player.whoAmI)
    
    -- Visual shockwave burst effect
    for i = 1, 25 do
        Dust:NewDust(npc.position, npc.width * 2, npc.height * 2, 62, math.random(-5, 5), math.random(-5, 5), 100, "Purple", 1.5)
    end
end

return BlackHoleStaff
