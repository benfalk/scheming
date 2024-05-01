# frozen_string_literal: true

RSpec.describe Scheming::Type::Enum do
  let(:instance) { described_class.new(type, values:) }
  let(:type) { build(:string_type) }
  let(:values) { %w[foo bar].to_set }

  it do
    expect(instance.type).to be(type)
    expect(instance.values).to be(values)
    expect(Scheming::Schema.json(instance)).to eq(
      enum: values,
      type: 'string'
    )
  end
end
