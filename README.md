# Velocity Calculator Datapack

Per-player velocity calculator for Minecraft datapacks with multiplayer-safe scoreboard state.

## Features

- Calculates exact movement velocity from player position deltas every tick.
- Keeps all values per player in scoreboard objectives.
- Outputs speed in:
  - Blocks per tick (`VelocityBPT`, scaled by 1000)
  - Blocks per second (`VelocityBPS`, scaled by 1000)
- Shows live speed in actionbar with three decimal places.
- Includes teleport/dimension spike protection.

## Folder Structure

```text
velocity_calculator/
├── pack.mcmeta
├── README.md
└── data/
    ├── minecraft/
    │   └── tags/
    │       └── function/
    │           ├── load.json
    │           └── tick.json
    └── velocity/
        └── function/
            ├── lifecycle/
            │   ├── load.mcfunction
            │   └── tick.mcfunction
            ├── calc/
            │   ├── player_tick.mcfunction
            │   ├── speed_nonzero.mcfunction
            │   ├── speed_zero.mcfunction
            │   └── sqrt_step.mcfunction
            ├── safety/
            │   └── reset_velocity.mcfunction
            └── ui/
                ├── update.mcfunction
                ├── text_frac_2zeros.mcfunction
                ├── text_frac_1zero.mcfunction
                └── text_frac_nozero.mcfunction
```

## Execution Flow

1. `minecraft:load` runs `velocity:lifecycle/load`.
2. `minecraft:tick` runs `velocity:lifecycle/tick`.
3. `velocity:lifecycle/tick` executes `velocity:calc/player_tick` as every online player.
4. `velocity:calc/player_tick` updates position history, calculates deltas, squares, and total speed squared.
5. Branch behavior:
- `velocity:calc/speed_zero` when speed is zero.
- `velocity:calc/speed_nonzero` when speed is non-zero.
6. `velocity:ui/update` updates actionbar text for that player context.

## Scoreboard Objectives

- `Constants`: fake-player constants.
- `PosX`, `PosY`, `PosZ`: current position, scaled by 1000.
- `PastPosX`, `PastPosY`, `PastPosZ`: previous tick position, scaled by 1000.
- `Vx`, `Vy`, `Vz`: per-axis deltas.
- `Vx2`, `Vy2`, `Vz2`: squared deltas.
- `SpeedSquared`: `Vx2 + Vy2 + Vz2`.
- `Estimate`: Newton-Raphson estimate for sqrt.
- `Temp`: temporary value for Newton-Raphson division step.
- `VelocityBPT`: velocity in blocks/tick, scaled by 1000.
- `VelocityBPS`: velocity in blocks/second, scaled by 1000.
- `VelocityInt`: integer part of `VelocityBPS / 1000`.
- `VelocityFrac`: fractional part of `VelocityBPS % 1000`.

## Constants

- `#TWO` = 2
- `#TWENTY` = 20
- `#THOUSAND` = 1000
- `#MAX_COMPONENT_DELTA` = 26000
- `#MIN_COMPONENT_DELTA` = -26000
- `#MAX_SPEED_SQ` = 25000000

## Math Details

Position precision uses `x1000` scaling so scoreboard integer math can represent decimals.

- Delta per axis:
  - `Vx = PosX - PastPosX`
  - `Vy = PosY - PastPosY`
  - `Vz = PosZ - PastPosZ`
- Sum of squares:
  - `SpeedSquared = Vx^2 + Vy^2 + Vz^2`
- Square root approximation uses Newton-Raphson iterations:
  - `Estimate = (Estimate + SpeedSquared / Estimate) / 2`
- Final units:
  - `VelocityBPT = sqrt(SpeedSquared)`
  - `VelocityBPS = VelocityBPT * 20`

Because values are scaled by 1000, displayed BPS is formatted as `VelocityBPS / 1000` with three decimal places.

## Display Behavior

- Text format: `Speed X.XXX bps`
- Actionbar color: green
- Actionbar is per-player and fully multiplayer-safe.

## Tuning Guide

You can tune these constants in `velocity:lifecycle/load` and run `/reload`:

- Increase `#MAX_COMPONENT_DELTA` if high-speed movement mods are clipped.
- Increase `#MAX_SPEED_SQ` if legitimate speed spikes are reset.

## Use

1. Put the datapack in your world `datapacks` folder.
2. Run `/reload`.
3. Move or sprint and observe actionbar speed.
4. If you used an older bossbar version of this pack, run `/bossbar remove velocity:speed` once.

## Notes

- Score calculations are per-player and multiplayer-safe.
- UI output is actionbar-only to keep multiplayer behavior fully independent.
