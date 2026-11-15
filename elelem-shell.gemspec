# frozen_string_literal: true

require_relative "lib/elelem/shell/version"

Gem::Specification.new do |spec|
  spec.name = "elelem-shell"
  spec.version = Elelem::Shell::VERSION
  spec.authors = ["mo khan"]
  spec.email = ["mo@mokhan.ca"]

  spec.summary = "elelem with its pure Ruby plugins and providers in one install."
  spec.description = "Installs elelem with the tools, mcp, skills and server plugins and " \
                     "the openai, anthropic and ollama providers."
  spec.homepage = "https://elelem.sh"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 4.0.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elelem-sh/shell"
  spec.metadata["rubygems_mfa_required"] = "true"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "elelem", ">= 0.13", "< 1"
  spec.add_dependency "elelem-anthropic", ">= 0.2", "< 1"
  spec.add_dependency "elelem-mcp", ">= 0.2", "< 1"
  spec.add_dependency "elelem-ollama", ">= 0.2", "< 1"
  spec.add_dependency "elelem-openai", ">= 0.2", "< 1"
  spec.add_dependency "elelem-server", ">= 0.2", "< 1"
  spec.add_dependency "elelem-skills", ">= 0.3", "< 1"
  spec.add_dependency "elelem-tools", ">= 0.2", "< 1"
end
