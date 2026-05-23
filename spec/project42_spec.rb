# frozen_string_literal: true

RSpec.describe Project42 do
  it "project has a version number 0.1.0" do
    expect(Project42::VERSION).not_to be nil
    expect(Project42::VERSION).to be "0.1.0"
  end

  it "does something useful" do
    expect(true).to eq(true)
  end

  it "ruby version 3.4.9" do
    expect(RUBY_VERSION).to eq("3.4.9")
  end
end
