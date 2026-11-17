# frozen_string_literal: true

require "elelem"
require "elelem/cli"

require_relative "shell/version"
require_relative "shell/default_provider"

require "elelem/tools"
require "elelem/mcp"
require "elelem/skills"

module Elelem
  module Shell
    PROVIDER_FLAG = /\A(-p|--p)/
    NOTICE = "elelem: no model or API key found; using the demo provider. " \
             "Run curl -fsSL https://elelem.sh/install | sh, or set ANTHROPIC_API_KEY or OPENAI_API_KEY."

    def self.default_provider(env = ENV, models_dir: "~/.agents/models")
      DefaultProvider.new(env, models_dir: models_dir).name
    end

    def self.start(args, env: ENV, models_dir: "~/.agents/models", err: $stderr)
      default = DefaultProvider.new(env, models_dir: models_dir)
      err.puts(NOTICE) if default.fallback? && args.grep(PROVIDER_FLAG).empty?
      CLI.new(args, provider: default.name).run
    end
  end
end
