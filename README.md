# elelem-shell

One gem that installs [elelem](https://elelem.sh) with its pure Ruby plugins
and providers.

## Install

```sh
gem install elelem-shell
```

Then run `elelem-shell`. It is `elelem` with elelem-tools, elelem-mcp and
elelem-skills loaded. Pick a provider with `-p NAME`.

To run it without installing, use [rv](https://rv.dev):

```sh
rvx elelem-shell
```

## What it installs

- elelem
- elelem-tools, elelem-mcp, elelem-skills
- elelem-openai, elelem-anthropic, elelem-ollama
- elelem-server, the `elelem-server` web UI

## What it leaves out

- elelem-llama, elelem-ratatui, elelem-candle, elelem-ggml, elelem-llama2 and
  elelem-diffusion build native extensions at install time. Install them on
  their own when you want them.
- elelem-evals runs evals against providers. It is for developing elelem.

## License

MIT. See LICENSE.txt.
