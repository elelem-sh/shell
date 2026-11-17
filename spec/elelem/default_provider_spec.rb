# frozen_string_literal: true

require "tmpdir"

RSpec.describe Elelem::Shell do
  around do |example|
    Dir.mktmpdir do |dir|
      @models_dir = dir
      example.run
    end
  end

  def detect(env = {}) = described_class.default_provider(env, models_dir: @models_dir)

  def add_model(name = "tiny.gguf") = File.write(File.join(@models_dir, name), "")

  describe ".default_provider" do
    {
      "ANTHROPIC_API_KEY" => "anthropic",
      "OPENAI_API_KEY" => "openai",
      "OPENAI_BASE_URL" => "openai",
      "GEMINI_API_KEY" => "gemini",
      "OPENROUTER_API_KEY" => "openrouter",
      "GROQ_API_KEY" => "groq",
      "MISTRAL_API_KEY" => "mistral",
      "CEREBRAS_API_KEY" => "cerebras",
      "OLLAMA_HOST" => "ollama"
    }.each do |name, provider|
      it "picks #{provider} when #{name} is set" do
        expect(detect(name => "value")).to eq(provider)
      end

      it "ignores a blank #{name}" do
        expect(detect(name => " \n")).to eq("demo")
      end
    end

    it "falls back to demo" do
      expect(detect).to eq("demo")
    end

    it "picks the value of ELELEM_PROVIDER first" do
      expect(detect("ELELEM_PROVIDER" => "github", "ANTHROPIC_API_KEY" => "key")).to eq("github")
    end

    it "ignores a blank ELELEM_PROVIDER" do
      expect(detect("ELELEM_PROVIDER" => " ", "ANTHROPIC_API_KEY" => "key")).to eq("anthropic")
    end

    it "prefers the hosted providers in order" do
      names = %w[ANTHROPIC_API_KEY OPENAI_API_KEY GEMINI_API_KEY OPENROUTER_API_KEY GROQ_API_KEY MISTRAL_API_KEY
                 CEREBRAS_API_KEY CLOUDFLARE_API_TOKEN CLOUDFLARE_ACCOUNT_ID]
      env = names.to_h { |name| [name, "value"] }
      picks = names.map { |name| detect(env).tap { env.delete(name) } }

      expect(picks).to eq(%w[anthropic openai gemini openrouter groq mistral cerebras cloudflare demo])
    end

    it "picks cloudflare when the token and the account id are set" do
      expect(detect("CLOUDFLARE_API_TOKEN" => "token", "CLOUDFLARE_ACCOUNT_ID" => "id")).to eq("cloudflare")
    end

    it "ignores a cloudflare token without an account id" do
      expect(detect("CLOUDFLARE_API_TOKEN" => "token")).to eq("demo")
    end

    it "ignores a cloudflare account id without a token" do
      expect(detect("CLOUDFLARE_ACCOUNT_ID" => "id", "CLOUDFLARE_API_TOKEN" => "")).to eq("demo")
    end

    it "ignores GITHUB_TOKEN and GH_TOKEN" do
      expect(detect("GITHUB_TOKEN" => "token", "GH_TOKEN" => "token")).to eq("demo")
    end

    it "picks llama when the models directory holds one model" do
      add_model

      expect(detect).to eq("llama")
    end

    it "picks llama when ELELEM_GGUF_MODEL is set, even to a missing file" do
      expect(detect("ELELEM_GGUF_MODEL" => "/nonexistent/model.gguf")).to eq("llama")
    end

    it "skips llama when the models directory holds several models and no default" do
      add_model("one.gguf")
      add_model("two.gguf")

      expect(detect).to eq("demo")
    end

    it "prefers an API key to a local model" do
      add_model

      expect(detect("CEREBRAS_API_KEY" => "key")).to eq("cerebras")
    end

    it "prefers a local model to ollama" do
      add_model

      expect(detect("OLLAMA_HOST" => "localhost:11434")).to eq("llama")
    end

    it "does not load fiddle" do
      add_model
      detect

      expect($LOADED_FEATURES.grep(%r{/fiddle\.(rb|so)\z})).to be_empty
    end
  end
end
