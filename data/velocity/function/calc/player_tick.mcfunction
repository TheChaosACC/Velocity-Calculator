# 1) Shift current tracked positions into one-tick history.
scoreboard players operation @s PastPosX = @s PosX
scoreboard players operation @s PastPosY = @s PosY
scoreboard players operation @s PastPosZ = @s PosZ

# 2) Pull current position into scaled integer scores (x1000 precision).
execute store result score @s PosX run data get entity @s Pos[0] 1000
execute store result score @s PosY run data get entity @s Pos[1] 1000
execute store result score @s PosZ run data get entity @s Pos[2] 1000

# 3) Delta components: V = Pos - PastPos
scoreboard players operation @s Vx = @s PosX
scoreboard players operation @s Vx -= @s PastPosX
scoreboard players operation @s Vy = @s PosY
scoreboard players operation @s Vy -= @s PastPosY
scoreboard players operation @s Vz = @s PosZ
scoreboard players operation @s Vz -= @s PastPosZ

# 4) Clamp extreme component deltas to avoid overflow and teleport spikes.
execute if score @s Vx > #MAX_COMPONENT_DELTA Constants run scoreboard players set @s Vx 0
execute if score @s Vx < #MIN_COMPONENT_DELTA Constants run scoreboard players set @s Vx 0
execute if score @s Vy > #MAX_COMPONENT_DELTA Constants run scoreboard players set @s Vy 0
execute if score @s Vy < #MIN_COMPONENT_DELTA Constants run scoreboard players set @s Vy 0
execute if score @s Vz > #MAX_COMPONENT_DELTA Constants run scoreboard players set @s Vz 0
execute if score @s Vz < #MIN_COMPONENT_DELTA Constants run scoreboard players set @s Vz 0

# 5) Component squares
scoreboard players operation @s Vx2 = @s Vx
scoreboard players operation @s Vx2 *= @s Vx
scoreboard players operation @s Vy2 = @s Vy
scoreboard players operation @s Vy2 *= @s Vy
scoreboard players operation @s Vz2 = @s Vz
scoreboard players operation @s Vz2 *= @s Vz

# 6) Sum of squares
scoreboard players operation @s SpeedSquared = @s Vx2
scoreboard players operation @s SpeedSquared += @s Vy2
scoreboard players operation @s SpeedSquared += @s Vz2

# 7) Teleport/dimension spike protection on scalar velocity.
execute if score @s SpeedSquared > #MAX_SPEED_SQ Constants run function velocity:safety/reset_velocity

# 8) Zero-speed and non-zero-speed branches.
execute if score @s SpeedSquared matches 0 run function velocity:calc/speed_zero
execute if score @s SpeedSquared matches 1.. run function velocity:calc/speed_nonzero

# 9) UI output.
function velocity:ui/update
