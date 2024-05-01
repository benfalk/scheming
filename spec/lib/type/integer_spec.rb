# frozen_string_literal: true

RSpec.describe Scheming::Type::Integer do
  let(:instance) { described_class.new }

  it do
    expect(instance).to be_a(described_class)
    expect(Scheming::Schema.json(instance)).to eq(type: 'integer')
  end
end
