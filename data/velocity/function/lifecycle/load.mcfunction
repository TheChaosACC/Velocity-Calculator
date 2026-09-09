# Scoreboards for exact per-player position, delta, and velocity math.
scoreboard objectives add Constants dummy
scoreboard objectives add PosX dummy
scoreboard objectives add PosY dummy
scoreboard objectives add PosZ dummy
scoreboard objectives add PastPosX dummy
scoreboard objectives add PastPosY dummy
scoreboard objectives add PastPosZ dummy
scoreboard objectives add Vx dummy
scoreboard objectives add Vy dummy
scoreboard objectives add Vz dummy
scoreboard objectives add Vx2 dummy
scoreboard objectives add Vy2 dummy
scoreboard objectives add Vz2 dummy
scoreboard objectives add SpeedSquared dummy
scoreboard objectives add Estimate dummy
scoreboard objectives add Temp dummy
scoreboard objectives add VelocityBPT dummy
scoreboard objectives add VelocityBPS dummy
scoreboard objectives add VelocityInt dummy
scoreboard objectives add VelocityFrac dummy

scoreboard players set #TWO Constants 2
scoreboard players set #TWENTY Constants 20
scoreboard players set #THOUSAND Constants 1000
scoreboard players set #MAX_COMPONENT_DELTA Constants 26000
scoreboard players set #MIN_COMPONENT_DELTA Constants -26000
scoreboard players set #MAX_SPEED_SQ Constants 25000000
