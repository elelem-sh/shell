# frozen_string_literal: true

module Elelem
  module Shell
    class DefaultProvider
      FALLBACK = "demo"
      KEYS = {
        "anthropic" => [%w[ANTHROPIC_API_KEY]],
        "openai" => [%w[OPENAI_API_KEY], %w[OPENAI_BASE_URL]],
        "gemini" => [%w[GEMINI_API_KEY]],
        "openrouter" => [%w[OPENROUTER_API_KEY]],
        "groq" => [%w[GROQ_API_KEY]],
        "mistral" => [%w[MISTRAL_API_KEY]],
        "cerebras" => [%w[CEREBRAS_API_KEY]],
        "cloudflare" => [%w[CLOUDFLARE_API_TOKEN CLOUDFLARE_ACCOUNT_ID]]
      }.freeze

      def initialize(env = ENV, models_dir: "~/.agents/models")
        @env = env
        @models_dir = models_dir
      end

      def name = detected || FALLBACK

      def fallback? = detected.nil?

      private

      def detected = value("ELELEM_PROVIDER") || keyed || local

      def keyed
        KEYS.find { |_, alternatives| alternatives.any? { |names| names.all? { |name| value(name) } } }&.first
      end

      def local
        return "llama" if llama?

        "ollama" if value("OLLAMA_HOST")
      end

      def llama?
        require "elelem/llama/model_resolver"
        Llama::ModelResolver.resolve(model: nil, env: @env, models_dir: @models_dir)
        true
      rescue LoadError, RuntimeError
        false
      end

      def value(name)
        @env[name].to_s.strip.then { |text| text unless text.empty? }
      end
    end
  end
end
