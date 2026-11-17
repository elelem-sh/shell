# frozen_string_literal: true

module Elelem
  module Shell
    class DefaultProvider
      FALLBACK = "demo"
      KEYS = {
        "anthropic" => [%w[ANTHROPIC_API_KEY]],
        "openai" => [%w[OPENAI_API_KEY], %w[OPENAI_BASE_URL]],
        "gemini" => [%w[GEMINI_API_KEY GEMINI_MODEL]],
        "openrouter" => [%w[OPENROUTER_API_KEY OPENROUTER_MODEL]],
        "groq" => [%w[GROQ_API_KEY GROQ_MODEL]],
        "mistral" => [%w[MISTRAL_API_KEY MISTRAL_MODEL]],
        "cerebras" => [%w[CEREBRAS_API_KEY CEREBRAS_MODEL]],
        "cloudflare" => [%w[CLOUDFLARE_API_TOKEN CLOUDFLARE_ACCOUNT_ID CLOUDFLARE_MODEL]]
      }.freeze

      def initialize(env = ENV, models_dir: "~/.agents/models")
        @env = env
        @models_dir = models_dir
      end

      def name = detected || FALLBACK

      def fallback? = detected.nil?

      private

      def detected
        return @detected if defined?(@detected)

        @detected = value("ELELEM_PROVIDER") || keyed || local
      end

      def keyed
        KEYS.find { |_, alternatives| alternatives.any? { |names| names.all? { |name| value(name) } } }&.first
      end

      def local
        return "llama" if llama?

        "ollama" if value("OLLAMA_HOST")
      end

      def llama?
        require "elelem/llama/model_resolver"
        Llama::ModelResolver.resolve(model: nil, env: resolver_env, models_dir: @models_dir)
        true
      rescue LoadError, RuntimeError
        false
      end

      def resolver_env
        value("ELELEM_GGUF_MODEL") ? @env : @env.to_h.except("ELELEM_GGUF_MODEL")
      end

      def value(name)
        @env[name].to_s.strip.then { |text| text unless text.empty? }
      end
    end
  end
end
