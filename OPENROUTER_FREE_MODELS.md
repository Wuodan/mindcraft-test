# OpenRouter Free LLM Selection for Bots

Date evaluated: March 5, 2026

## Goal
Choose free OpenRouter models that are less likely to be rate limited while still being suitable for bot workloads (including tool usage and structured outputs where needed).

## Recommended model stack

1. `openrouter/free` (primary)
2. `stepfun/step-3.5-flash:free` (first explicit fallback)
3. `nvidia/nemotron-nano-9b-v2:free` (second fallback)
4. `arcee-ai/trinity-mini:free` (third fallback)
5. `mistralai/mistral-small-3.1-24b-instruct:free` (hard-prompt fallback)

## Why this ordering

- `openrouter/free` is a free-model router and is the best hedge against single-endpoint congestion.
- The fallback models are practical instruct-style models that support typical bot tasks.
- Very large free models (for example 70B/120B/405B free variants) were not selected as defaults because they are generally less predictable under load for sustained bot traffic.

## Important tradeoff

- `openrouter/free` improves availability but can reduce output consistency because the underlying model may vary between requests.
- If consistency is more important than availability, pin one model as primary and keep the rest strictly as retries/fallbacks.

## Operational guidance

- Use retries with exponential backoff and jitter on `429` and `5xx`.
- Keep explicit cross-family fallbacks enabled.
- Route routine turns to smaller/cheaper models; reserve the harder fallback for difficult prompts.

## Sources

- https://openrouter.ai/models?q=free&order=latency-low-to-high
- https://openrouter.ai/api/v1/models
- https://openrouter.ai/api/frontend/models?q=free
