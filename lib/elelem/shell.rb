# frozen_string_literal: true

require "elelem"
require "elelem/cli"

require_relative "shell/version"

require "elelem/tools"
require "elelem/mcp"
require "elelem/skills"

module Elelem
  module Shell
    NOTICE = "elelem: elelem-llama is not available; using the demo provider, which runs each prompt as a command. " \
             "Run curl -fsSL https://elelem.sh/install | sh, or pick a provider with -p.\n"

    def self.start(args, env: ENV)
      name = env["ELELEM_PROVIDER"].to_s.strip
      CLI.new(args, provider: name.empty? ? "default" : name).run
    end
  end
end

Elelem.configure do |config|
  config.provider(:default) do |**options|
    require "elelem/llama"
    Elelem::Config.build_provider("llama", **options)
  rescue LoadError => e
    raise unless e.path == "elelem/llama"

    $stderr.write Elelem::Shell::NOTICE
    Elelem::Config.build_provider("demo", **options)
  end
end
