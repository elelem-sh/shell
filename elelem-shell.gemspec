# frozen_string_literal: true

require_relative "lib/elelem/shell/version"

Gem::Specification.new do |spec|
  spec.name = "elelem-shell"
  spec.version = Elelem::Shell::VERSION
  spec.authors = ["mo khan"]
  spec.email = ["mo@mokhan.ca"]

  spec.summary = "elelem with its pure Ruby plugins and providers in one install."
  spec.description = "Installs elelem with the tools, mcp, skills and server plugins and the " \
                     "anthropic, cerebras, cloudflare, gemini, github, groq, mistral, ollama, " \
                     "openai and openrouter providers, and picks a default provider from the environment."
  spec.homepage = "https://elelem.sh"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 4.0.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elelem-sh/shell"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["LICENSE.txt", "lib/**/*.rb", "exe/*"]
  spec.bindir = "exe"
  spec.executables = ["elelem-shell"]
  spec.require_paths = ["lib"]

  spec.add_dependency "elelem", ">= 0.18", "< 1"
  spec.add_dependency "elelem-anthropic", ">= 0.3", "< 1"
  spec.add_dependency "elelem-cerebras", ">= 0.1", "< 1"
  spec.add_dependency "elelem-cloudflare", ">= 0.1", "< 1"
  spec.add_dependency "elelem-gemini", ">= 0.1", "< 1"
  spec.add_dependency "elelem-github", ">= 0.1", "< 1"
  spec.add_dependency "elelem-groq", ">= 0.1", "< 1"
  spec.add_dependency "elelem-mcp", ">= 0.2", "< 1"
  spec.add_dependency "elelem-mistral", ">= 0.1", "< 1"
  spec.add_dependency "elelem-ollama", ">= 0.2", "< 1"
  spec.add_dependency "elelem-openai", ">= 0.5", "< 1"
  spec.add_dependency "elelem-openrouter", ">= 0.1", "< 1"
  spec.add_dependency "elelem-server", ">= 0.2", "< 1"
  spec.add_dependency "elelem-skills", ">= 0.3", "< 1"
  spec.add_dependency "elelem-tools", ">= 0.3", "< 1"
end
