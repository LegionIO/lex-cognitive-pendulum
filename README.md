# lex-cognitive-pendulum

Models oscillation between cognitive poles for brain-modeled agentic AI. Pendulums swing between paired cognitive extremes, with amplitude, period, and damping controlling the oscillation dynamics. Resonance occurs when external stimuli match a pendulum's natural frequency.

## Overview

`lex-cognitive-pendulum` gives the agent a way to track where it sits between cognitive extremes — certain vs. doubtful, focused vs. diffuse, analytical vs. intuitive. Multiple independent pendulums can run simultaneously, and the engine surfaces which poles are dominant, which pendulums are most active, and which ones resonate with incoming stimuli.

## Pole Pairs

| Pair | Pole A | Pole B |
|------|--------|--------|
| `certainty_doubt` | certainty | doubt |
| `focus_diffusion` | focus | diffusion |
| `analysis_intuition` | analysis | intuition |
| `approach_avoidance` | approach | avoidance |
| `convergent_divergent` | convergent | divergent |

## Key Concepts

**Amplitude** (0.0–1.0): How far the pendulum swings from center. Higher amplitude = stronger pull toward one pole.

**Period** (seconds): Time for one full oscillation cycle. Shorter period = faster cycling.

**Damping**: Rate at which amplitude decays each cycle. Default is 0.01 (1% per damp cycle).

**Resonance**: A pendulum resonates when an external stimulus frequency is within 5% of its natural frequency (1/period).

**Dominant pole**: The pole the pendulum is currently closest to. Returns `:neutral` when position is within ±0.1 of center.

## Amplitude Labels

| Amplitude | Label |
|-----------|-------|
| 0.0–0.2 | `:minimal` |
| 0.2–0.4 | `:low` |
| 0.4–0.6 | `:moderate` |
| 0.6–0.8 | `:high` |
| 0.8–1.0 | `:maximal` |

## Installation

Add to your Gemfile:

```ruby
gem 'lex-cognitive-pendulum'
```

## Usage

### Creating and Swinging a Pendulum

```ruby
require 'legion/extensions/cognitive_pendulum'

client = Legion::Extensions::CognitivePendulum::Client.new

result = client.create_pendulum(
  pole_pair: :certainty_doubt,
  amplitude: 0.7,
  period:    15.0,
  damping:   0.02
)
# => { success: true, pendulum_id: "uuid", pole_pair: :certainty_doubt, amplitude: 0.7 }

client.swing(pendulum_id: result[:pendulum_id], force: 0.6)
# => { success: true, pendulum_id: "uuid", current_position: 0.6, dominant_pole: :doubt }
```

### Checking Resonance

```ruby
# Stimuli arriving at 0.1 Hz — does any pendulum resonate?
client.check_resonance(frequency: 0.1)
# => { success: true, frequency: 0.1, resonant_pendulum_ids: ["uuid"], count: 1 }
```

### Engine Reports

```ruby
# Which pendulums are most active?
client.most_active(limit: 3)

# Which are most damped (quietest)?
client.most_damped(limit: 3)

# Full report
client.pendulum_report
# => { success: true, report: { total: 5, max: 100, pole_pairs: {...}, ... } }
```

### Damping All Pendulums

```ruby
client.damp_all
# => { success: true, damped: 5 }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
