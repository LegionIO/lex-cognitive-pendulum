# lex-cognitive-pendulum

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Oscillation model for cognitive pole pairs. Pendulums swing between opposing cognitive states (certainty/doubt, focus/diffusion, analysis/intuition, approach/avoidance, convergent/divergent thinking). Physical simulation: damped harmonic oscillation via `position_at(time)` using the formula `amplitude * cos(2π * time / period) * e^(-damping * time)`. Resonance detection identifies pendulums that are oscillating in synchrony.

## Gem Info

- **Gem name**: `lex-cognitive-pendulum`
- **Module**: `Legion::Extensions::CognitivePendulum`
- **Version**: `0.1.0`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_pendulum/
  version.rb
  client.rb
  helpers/
    constants.rb
    pendulum.rb
  runners/
    cognitive_pendulum.rb
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `POLE_PAIRS` | 5 pairs | `certainty_doubt`, `focus_diffusion`, `analysis_intuition`, `approach_avoidance`, `convergent_divergent` |
| `DAMPING_RATE` | `0.01` | Per-cycle damping applied to amplitude and position |
| `MAX_PENDULUMS` | `100` | Per-engine pendulum capacity |
| `AMPLITUDE_LABELS` | range hash | From `:still` to `:wild` |

## Helpers

### `Helpers::Pendulum`
Individual oscillating pendulum. Has `id`, `pole_pair`, `position` (-1.0 to 1.0), `amplitude` (0.0–1.0), `period` (seconds), and `damping`.

- `swing!(force)` — applies force to position; clamps position to [-1.0, 1.0]; resets amplitude if needed
- `damp!` — reduces both amplitude and position by `DAMPING_RATE`
- `position_at(time)` — returns `amplitude * cos(2π * time / period) * exp(-damping * time)` (damped cosine)
- `at_pole_a?` — position <= -0.7 (strongly at the first pole)
- `at_pole_b?` — position >= 0.7 (strongly at the second pole)
- `dominant_pole` — `:pole_a`, `:pole_b`, or `:center`
- `resonant_with?(other_pendulum)` — true if same pole_pair and periods are within 10%
- `amplitude_label`

## Runners

Module: `Runners::CognitivePendulum`

| Runner Method | Description |
|---|---|
| `create_pendulum(pole_pair:, position:, amplitude:, period:, damping:)` | Create a new oscillator |
| `swing(pendulum_id:, force:)` | Apply force to the pendulum |
| `damp_all` | Apply damping to all pendulums |
| `check_resonance(pendulum_a_id:, pendulum_b_id:)` | Check if two pendulums resonate |
| `get_dominant_pole(pendulum_id:)` | Current dominant pole |
| `most_active(limit:)` | Pendulums with highest amplitude |
| `most_damped(limit:)` | Pendulums with lowest amplitude |
| `pendulum_report` | Aggregate oscillation stats |
| `get_pendulum(pendulum_id:)` | Single pendulum details |

All runners return `{success: true/false, ...}` hashes.

## Integration Points

- `lex-tick` `action_selection`: `dominant_pole` determines current cognitive mode (e.g., analysis vs intuition pendulum at pole_a = full analysis mode)
- `lex-emotion`: emotional valence can drive `swing!` force — positive emotion pushes toward approach pole, negative toward avoidance
- `lex-conflict`: convergent/divergent pendulum models the tension between solution convergence and continued exploration
- Resonant pendulums across multiple dimensions signal a stable cognitive state; non-resonance signals oscillatory instability

## Development Notes

- `Client` instantiates `@pendulum_engine = Helpers::PendulumEngine.new`
- `POLE_PAIRS` is defined as a constant hash; `create_pendulum` validates `pole_pair` against it
- `position_at(time)` is a pure physics formula — it takes wall-clock time as input, not cycle count
- `damping` is a per-pendulum attribute set at creation; `DAMPING_RATE` is the default when `damp!` is called without arguments
- Resonance check uses period similarity (within 10%) not phase alignment — approximate resonance detection
