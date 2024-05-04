# frozen_string_literal: true

RSpec.describe Scheming::Type::Union do
  let(:instance) { described_class.new(types) }

  context 'with a single type' do
    let(:types) { [build(:int_type)] }

    it do
      expect(instance.types).to eq(types)
      expect(Scheming::Schema.json(instance)).to be_valid_json_schema
      expect(Scheming::Schema.json(instance)).to eq(
        { oneOf: [{ type: 'integer' }] }
      )
    end
  end

  context 'with several types' do
    let(:types) { [build(:int_type), build(:float_type)] }

    it do
      expect(instance.types).to eq(types)
      expect(Scheming::Schema.json(instance)).to be_valid_json_schema
      expect(Scheming::Schema.json(instance)).to eq(
        { oneOf: [{ type: 'integer' }, { type: 'number' }] }
      )
    end
  end
end
