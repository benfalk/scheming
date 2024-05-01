# frozen_string_literal: true

RSpec.describe Scheming::Type::Array do
  let(:type) { Scheming::Type::Float.new }
  let(:instance) { described_class.new(type) }

  it do
    expect(instance.type).to eq(type)
    expect(Scheming::Schema.json(instance))
      .to be_valid_json_schema
    expect(Scheming::Schema.json(instance)).to eq(
      {
        type: 'array',
        items: { type: 'number' }
      }
    )
  end
end
