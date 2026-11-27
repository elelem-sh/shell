# frozen_string_literal: true

RSpec.describe "elelem/shell" do
  let(:session) { Elelem.build(provider: "demo", input: Elelem::NullInput.new, output: Elelem::NullOutput.new) }

  it "adds the elelem-tools tools" do
    expect(session.toolbox.tools.keys).to include("edit", "git", "grep", "verify")
  end

  it "adds the elelem-skills commands" do
    expect(session.commands.names).to include("/skills")
  end

  it "adds the elelem-hub commands" do
    expect(session.commands.names).to include("/login", "/logout")
  end

  it "loads elelem-mcp" do
    expect(require("elelem/mcp")).to be(false)
  end
end
