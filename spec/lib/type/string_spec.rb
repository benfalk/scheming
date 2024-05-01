# frozen_string_literal: true

RSpec.describe Scheming::Type::String do
  let(:instance) { described_class.new }

  it do
    expect(instance).to be_a(described_class)
    expect(Scheming::Schema.json(instance)).to eq(type: 'string')
  end
end
