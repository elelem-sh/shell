# elelem-shell

One gem that installs [elelem](https://elelem.sh) with its pure Ruby plugins
and providers.

## Install

```sh
gem install elelem-shell
mkdir -p ~/.agents/plugins && echo 'require "elelem/shell"' > ~/.agents/plugins/shell.rb
```

The second line turns on the opt-in plugins: `elelem/shell` requires
elelem-tools, elelem-mcp and elelem-skills. elelem loads a provider when you
pick it with `-p NAME`.

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
