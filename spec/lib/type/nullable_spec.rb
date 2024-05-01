# frozen_string_literal: true

RSpec.describe Scheming::Type::Nullable do
  let(:type) { Scheming::Type::Float.new }
  let(:instance) { described_class.new(type) }

  it do
    expect(instance.type).to eq(type)
    expect(Scheming::Schema.json(instance)).to eq(
      {
        oneOf: [
          { type: 'numeric' },
          { type: 'null' }
        ]
      }
    )
  end
end
