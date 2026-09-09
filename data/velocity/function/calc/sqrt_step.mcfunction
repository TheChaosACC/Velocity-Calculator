# Temp = SpeedSquared / Estimate
scoreboard players operation @s Temp = @s SpeedSquared
scoreboard players operation @s Temp /= @s Estimate

# Estimate = (Estimate + Temp) / 2
scoreboard players operation @s Estimate += @s Temp
scoreboard players operation @s Estimate /= #TWO Constants
