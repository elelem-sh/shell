# frozen_string_literal: true

RSpec.describe "elelem/shell" do
  def setups
    found = nil
    Elelem::Config.default.configure { |registration| found = registration.setups }
    found
  end

  def files_of(setups) = setups.values.map { |block| block.source_location&.first.to_s }

  it "registers the elelem-tools setups" do
    expect(files_of(setups)).to include(%r{/lib/elelem/tools/[a-z_]+\.rb\z})
  end

  it "registers the elelem-mcp setup" do
    expect(setups).to include("mcp")
    expect(files_of(setups.slice("mcp"))).to all(match(%r{/lib/elelem/mcp\.rb\z}))
  end

  it "registers the elelem-skills setup" do
    expect(setups).to include("skills")
    expect(files_of(setups.slice("skills"))).to all(match(%r{/lib/elelem/skills\.rb\z}))
  end

  it "has a version" do
    expect(Elelem::Shell::VERSION).to eq("0.1.0")
  end
end
