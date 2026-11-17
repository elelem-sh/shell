# frozen_string_literal: true

require "open3"
require "tmpdir"

RSpec.describe "exe/elelem-shell" do
  let(:root) { File.expand_path("../..", __dir__) }
  let(:detected) do
    %w[ELELEM_PROVIDER ANTHROPIC_API_KEY OPENAI_API_KEY OPENAI_BASE_URL GEMINI_API_KEY OPENROUTER_API_KEY
       GROQ_API_KEY MISTRAL_API_KEY CEREBRAS_API_KEY CLOUDFLARE_API_TOKEN CLOUDFLARE_ACCOUNT_ID ELELEM_GGUF_MODEL
       OLLAMA_HOST]
  end

  around do |example|
    Dir.mktmpdir do |home|
      @home = home
      example.run
    end
  end

  def env(overrides = {})
    gems = { "HOME" => @home, "GEM_HOME" => Gem.dir, "GEM_PATH" => Gem.path.join(File::PATH_SEPARATOR) }
    detected.to_h { |name| [name, nil] }.merge(gems, overrides)
  end

  def run(*, **overrides)
    Open3.capture3(env(overrides), RbConfig.ruby, "-I", "#{root}/lib", "#{root}/exe/elelem-shell", *, chdir: root)
  end

  it "runs elelem, reading a file with the demo provider" do
    output, error, status = run("ask", "@Gemfile")

    expect(status).to be_success
    expect(output + error).to include('gemspec name: "elelem-shell"')
  end

  it "prints its usage" do
    output, _, status = run("help")

    expect(status).to be_success
    expect(output).to include("Usage: elelem-shell")
  end

  it "shows the detected provider as the default" do
    output, = run("help", "MISTRAL_API_KEY" => "key")

    expect(output).to include("(default: mistral)")
  end

  it "says so when it falls back to the demo provider" do
    _, error, = run("help")

    expect(error).to eq("#{Elelem::Shell::NOTICE}\n")
  end

  it "stays quiet when a provider is detected" do
    _, error, = run("help", "ELELEM_PROVIDER" => "demo")

    expect(error).to be_empty
  end

  it "stays quiet when -p picks the provider" do
    _, error, = run("help", "-p", "demo")

    expect(error).to be_empty
  end

  it "stays quiet when --provider picks the provider" do
    _, error, = run("help", "--provider=demo")

    expect(error).to be_empty
  end
end
