# elelem-shell

One gem that installs [elelem](https://elelem.sh) with its pure Ruby plugins
and providers.

## Install

```sh
gem install elelem-shell
```

Then run `elelem-shell`. It is `elelem` with elelem-tools, elelem-mcp and
elelem-skills loaded.

## Default provider

Pick a provider with `-p NAME`. Without `-p`, the first match wins:

1. `ELELEM_PROVIDER`, its value
2. `ANTHROPIC_API_KEY`, anthropic
3. `OPENAI_API_KEY` or `OPENAI_BASE_URL`, openai
4. `GEMINI_API_KEY`, gemini
5. `OPENROUTER_API_KEY`, openrouter; `GROQ_API_KEY`, groq; `MISTRAL_API_KEY`,
   mistral; `CEREBRAS_API_KEY`, cerebras
6. `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`, cloudflare
7. llama, when elelem-llama is installed and `ELELEM_GGUF_MODEL` is set or
   `~/.agents/models` holds a model
8. `OLLAMA_HOST`, ollama
9. demo, which calls no model

A variable that is set but blank counts as unset. `GITHUB_TOKEN` is not
detected; use `-p github`.

To run it without installing, use [rv](https://rv.dev):

```sh
rvx elelem-shell
```

## What it installs

- elelem
- elelem-tools, elelem-mcp, elelem-skills
- elelem-anthropic, elelem-cerebras, elelem-cloudflare, elelem-gemini,
  elelem-github, elelem-groq, elelem-mistral, elelem-ollama, elelem-openai,
  elelem-openrouter
- elelem-server, the `elelem-server` web UI

## What it leaves out

- elelem-llama, elelem-ratatui, elelem-candle, elelem-ggml, elelem-llama2 and
  elelem-diffusion build native extensions at install time. Install them on
  their own when you want them. https://elelem.sh/install installs elelem-llama.
- elelem-evals runs evals against providers. It is for developing elelem.

## License

MIT. See LICENSE.txt.
