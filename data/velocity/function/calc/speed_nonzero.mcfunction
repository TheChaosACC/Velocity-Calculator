# Newton-Raphson sqrt for non-zero speed.
scoreboard players operation @s Estimate = @s SpeedSquared
scoreboard players operation @s Estimate /= #TWO Constants
execute if score @s Estimate matches 0 run scoreboard players set @s Estimate 1
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step
function velocity:calc/sqrt_step

# Final outputs.
scoreboard players operation @s VelocityBPT = @s Estimate
scoreboard players operation @s VelocityBPS = @s VelocityBPT
scoreboard players operation @s VelocityBPS *= #TWENTY Constants
