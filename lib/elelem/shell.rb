# frozen_string_literal: true

require "elelem"

require_relative "shell/version"

# The opt-in plugins. Providers are not required here: elelem loads a
# provider gem when it is picked with -p NAME.
require "elelem/tools"
require "elelem/mcp"
require "elelem/skills"
