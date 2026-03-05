# Ollama Model Image Recommendations for Lenovo Legion Pro 5 16ADR10 (32GB RAM)

Date evaluated: March 5, 2026

## Goal
Recommend practical Ollama model images (tags) to power bots locally, balancing quality and throughput on a Lenovo Legion Pro 5 16ADR10 with 32GB RAM.

## Hardware context researched

Lenovo PSREF for Legion Pro 5 16ADR10 lists:
- CPU options: AMD Ryzen 7 8745HX, Ryzen 9 8940HX, Ryzen 9 8945HX
- GPU options: NVIDIA GeForce RTX 5050/5060/5070 Laptop GPU
- GPU memory listed in PSREF: 8GB GDDR7 (discrete)
- Typical power target in PSREF table: 115W for these GPU options

Because exact CPU/GPU can vary by SKU, recommendations are selected to work well across the above GPU class and 32GB system RAM.

Confirmed on this machine from `nvidia-smi`:
- GPU: NVIDIA GeForce RTX 5070 Laptop GPU
- VRAM: 8151 MiB (~8GB)
- Driver/CUDA: 580.126.09 / CUDA 13.0
- Snapshot usage during desktop workload: 2807 MiB used, ~5344 MiB free

## Recommended Ollama images

1. `qwen3:4b-instruct`
- Best default for chat/planning style bot turns.
- Small enough to keep latency and VRAM pressure reasonable.

2. `qwen3:8b`
- Primary quality step-up from the 4B default.
- Good balance for your 8GB VRAM class when used selectively.

3. `qwen2.5-coder:7b`
- Preferred coding/tool-use model for code-heavy bot tasks.

4. `gemma3:4b`
- Use when you need vision-capable local inference (image input).
- Also useful for long-context workflows.

5. `qwen2.5-coder:14b`
- Higher coding quality option.
- Use selectively for harder tasks due to higher VRAM/RAM pressure.

6. `mistral-small:latest`
- Stronger reasoning/quality fallback for difficult prompts.
- Heavier model; keep it as an occasional escalation target.

## Why these were prioritized

- Keep default models in the 4B to 8B range for sustained bot throughput and reduced memory pressure.
- On your RTX 5070 Laptop 8GB, 7B/8B models are a strong daily sweet spot.
- Add one stronger coding tier (14B) only when needed.
- Keep one heavier quality fallback (`mistral-small`) for hard prompts, not as always-on default.
- Include one clear vision-capable option (`gemma3:4b`) for multimodal bots.

## Suggested pull commands

```bash
ollama pull qwen3:4b-instruct
ollama pull qwen3:8b
ollama pull qwen2.5-coder:7b
ollama pull gemma3:4b
ollama pull qwen2.5-coder:14b
# optional heavy fallback
ollama pull mistral-small:latest
```

## Operational notes

- Verify Ollama is using GPU acceleration on your machine after install.
- Prefer 4B to 8B for always-on/chat loops.
- Given your observed desktop VRAM usage, avoid setting 14B/heavier models as permanent default.
- Route harder coding or planning prompts to 14B/heavier models on demand.

## Comparison with current OpenRouter bot models

Current OpenRouter profiles in this repo use:
- `openrouter/free`
- `stepfun/step-3.5-flash:free`
- `nvidia/nemotron-nano-9b-v2:free`
- `arcee-ai/trinity-mini:free`
- `mistralai/mistral-small-3.1-24b-instruct:free`

Estimated behavior on this machine (RTX 5070 Laptop 8GB, 32GB RAM):
- Local Ollama models (4B to 8B) should be more consistent and available than free cloud endpoints (no provider-side free-tier rate limiting).
- Hard-prompt quality is still often higher on stronger cloud free models (especially `mistral-small-3.1-24b-instruct:free` and frequently `step-3.5-flash:free`).
- For coding/tool tasks, local `qwen2.5-coder:7b` and selective `qwen2.5-coder:14b` are competitive with the lighter OpenRouter free options.
- `openrouter/free` can occasionally outperform local models because routing may land on stronger backends, but output consistency is lower because backend selection can vary.

Practical conclusion:
- Use local Ollama as the default path for steady bot operation.
- Keep OpenRouter models as escalation/fallback for difficult prompts requiring higher reasoning quality.

## Sources

- Lenovo PSREF (official spec PDF):
  - https://psref.lenovo.com/syspool/Sys/PDF/Legion/Legion_Pro_5_16ADR10/Legion_Pro_5_16ADR10_Spec.pdf
- Notebookcheck model/config overview:
  - https://www.notebookcheck.net/Lenovo-Legion-Pro-5-16ADR10.1173636.0.html
- Ollama library tags:
  - https://ollama.com/library/qwen3/tags
  - https://ollama.com/library/qwen2.5-coder/tags
  - https://ollama.com/library/gemma3/tags
  - https://ollama.com/library/mistral-small/tags
- Ollama GPU support docs:
  - https://docs.ollama.com/gpu
