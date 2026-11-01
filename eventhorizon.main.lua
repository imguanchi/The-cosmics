local BlackHoleWhip = {
    name = "Event Horizon",
    texture = "weapon.png",
    damage = 110,
    damageType = "Summon",
    width = 30,
    height = 30,
    useTime = 30,
    useAnimation = 30,
    useStyle = 1,
    knockBack = 2,
    autoReuse = true,
    rare = 10,
    shoot = 841,
    shootSpeed = 4,
}

function BlackHoleWhip:OnHitNPC(player, npc, damage, knockback, crit)
    npc:AddBuff(310, 240)
    local spawnX = npc.position.X
    local spawnY = npc.position.Y
    
    local blackHole = Projectile:NewProjectile(spawnX, spawnY, 0, 0, 707, damage * 1.5, 0, player.whoAmI)
    
    LuAria:CreateTimer(function()
        npc.velocity.X = 0
        npc.velocity.Y = 0
        Dust:NewDust(npc.position, npc.width, npc.height, 62, 0, 0, 100, "Purple", 1.5)
    end, 60)
end

return BlackHoleWhip
