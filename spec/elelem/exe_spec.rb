# frozen_string_literal: true

require "open3"
require "tmpdir"

RSpec.describe "exe/elelem-shell" do
  let(:root) { File.expand_path("../..", __dir__) }
  around do |example|
    Dir.mktmpdir do |home|
      @home = home
      example.run
    end
  end

  def env(overrides = {})
    gems = { "HOME" => @home, "GEM_HOME" => Gem.dir, "GEM_PATH" => Gem.path.join(File::PATH_SEPARATOR) }
    bundle = { "RUBYOPT" => "-rbundler/setup", "BUNDLE_GEMFILE" => ENV.fetch("BUNDLE_GEMFILE", "#{root}/Gemfile") }
    { "ELELEM_PROVIDER" => nil, "ELELEM_GGUF_MODEL" => nil }.merge(gems, bundle, overrides)
  end

  def run(*, **overrides)
    Open3.capture3(env(overrides), RbConfig.ruby, "-I", "#{root}/lib", "#{root}/exe/elelem-shell", *, chdir: root)
  end

  def with_llama(source)
    Dir.mktmpdir do |dir|
      FileUtils.mkdir_p(File.join(dir, "elelem"))
      File.write(File.join(dir, "elelem", "llama.rb"), source)
      yield [dir, ENV.fetch("RUBYLIB", nil)].compact.join(File::PATH_SEPARATOR)
    end
  end

  it "runs elelem, reading a file with the demo provider" do
    output, error, status = run("@Gemfile", "-p", "demo")

    expect(status).to be_success
    expect(output + error).to include('gemspec name: "elelem-shell"')
  end

  it "prints its usage" do
    output, _, status = run("--help")

    expect(status).to be_success
    expect(output).to include("Usage: elelem-shell")
  end

  it "runs the demo provider, saying so, when elelem-llama is not installed" do
    output, error, status = run("@Gemfile", "ANTHROPIC_API_KEY" => "key")

    expect(status).to be_success
    expect(output + error).to include(Elelem::Shell::NOTICE, 'gemspec name: "elelem-shell"')
  end

  it "runs elelem-llama by default, despite an API key" do
    with_llama("Elelem.configure { |config| config.provider(:llama) { raise 'llama ran' } }") do |llama|
      _, error, = run("hi", "ANTHROPIC_API_KEY" => "key", "RUBYLIB" => llama)

      expect(error).to eq("elelem: llama ran\n")
    end
  end

  it "reports a broken elelem-llama instead of running the demo provider" do
    with_llama('require "elelem/missing"') do |llama|
      _, error, status = run("echo ran", "RUBYLIB" => llama)

      expect(status).not_to be_success
      expect(error).to eq("elelem: cannot load such file -- elelem/missing\n")
    end
  end

  it "runs the provider -p names despite a broken elelem-llama" do
    with_llama('require "elelem/missing"') do |llama|
      _, _, status = run("@Gemfile", "-p", "demo", "RUBYLIB" => llama)

      expect(status).to be_success
    end
  end

  it "uses ELELEM_PROVIDER" do
    output, = run("--help", "ELELEM_PROVIDER" => "mistral")

    expect(output).to include("(default: mistral)")
  end

  it "ignores a blank ELELEM_PROVIDER" do
    output, = run("--help", "ELELEM_PROVIDER" => " ")

    expect(output).to include("(default: default)")
  end
end
