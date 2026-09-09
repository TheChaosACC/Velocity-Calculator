# Convert scaled velocity into decimal components: int + frac(3 digits).
scoreboard players operation @s VelocityInt = @s VelocityBPS
scoreboard players operation @s VelocityInt /= #THOUSAND Constants
scoreboard players operation @s VelocityFrac = @s VelocityBPS
scoreboard players operation @s VelocityFrac %= #THOUSAND Constants

execute if score @s VelocityFrac matches ..9 run function velocity:ui/text_frac_2zeros
execute if score @s VelocityFrac matches 10..99 run function velocity:ui/text_frac_1zero
execute if score @s VelocityFrac matches 100.. run function velocity:ui/text_frac_nozero
