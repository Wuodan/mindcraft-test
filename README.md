# mindcraft-test

Slim runtime repo for local `mindcraft` experiments.

This repo keeps only local runtime artifacts (compose, profiles, minecraft config, docs) and builds the bot image directly from upstream `mindcraft`.

## Included migration scope

- Files changed on `mindcraft` branch `Wuodan` in range `200edcd7..HEAD`:
  - `docker-compose.yml`
  - `minecraft-config/bukkit.yml`
  - `minecraft-config/ops.json`
  - `profiles/bot_or_1.json` to `profiles/bot_or_5.json`
  - `OPENROUTER_FREE_MODELS.md`
  - `OLLAMA_LENOVO_LEGION_PRO_5_ANALYSIS.md`
- Adaptation: bot image is built from upstream `mindcraft` `develop` (configurable).

## Use

1. Prepare keys:
   - `cp keys.example.json keys.json`
   - set `OPENROUTER_API_KEY` in `keys.json` or via environment variable
2. Create host bind-mount directory as your user:
   - `mkdir -p bots`
3. Optional branch override (default is `develop`):
   - `export MINDCRAFT_REF=develop`
4. Start:
   - `docker compose up --build`

## Notes

- `bots/` is mounted into the container for generated action code/runtime state.
- `keys.json` and `profiles/` are mounted into `/app` in the bot container.
