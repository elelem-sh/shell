# elelem-shell

One gem that installs [elelem](https://elelem.sh) with its pure Ruby plugins
and providers.

## Install

```sh
gem install elelem-shell
```

Or, with no Ruby installed:

```sh
curl -fsSL https://elelem.sh/install | sh
```

Then run `elelem-shell`. It is `elelem` with elelem-tools, elelem-mcp and
elelem-skills loaded.

## Default provider

Pick a provider with `-p NAME` or `ELELEM_PROVIDER`. With neither,
`elelem-shell` runs llama when elelem-llama is installed, and demo when it is
not. demo calls no model: it runs each prompt as a command. An API key never
picks a provider.

A blank `ELELEM_PROVIDER` counts as unset. A plugin can replace the default:

```ruby
Elelem.configure do |config|
  config.provider(:default) { |**options| config.build_provider(:anthropic, **options) }
end
```

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
