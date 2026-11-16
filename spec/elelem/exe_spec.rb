# frozen_string_literal: true

require "open3"

RSpec.describe "exe/elelem-shell" do
  let(:root) { File.expand_path("../..", __dir__) }

  def run(*)
    Open3.capture2e(RbConfig.ruby, "-I", "#{root}/lib", "#{root}/exe/elelem-shell", *, chdir: root)
  end

  it "runs elelem, reading a file with the demo provider" do
    output, status = run("ask", "@Gemfile")

    expect(status).to be_success
    expect(output).to include('gemspec name: "elelem-shell"')
  end

  it "prints its usage" do
    output, status = run("help")

    expect(status).to be_success
    expect(output).to include("Usage: elelem-shell")
  end
end
