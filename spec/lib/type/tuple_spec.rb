# frozen_string_literal: true

RSpec.describe Scheming::Type::Tuple do
  let(:instance) { described_class.new(types) }

  context 'with two types' do
    let(:types) { [build(:int_type), build(:string_type)] }

    it do
      expect(instance.types).to eq(types)
      expect(Scheming::Schema.json(instance)).to be_valid_json_schema
      expect(Scheming::Schema.json(instance)).to eq(
        type: 'array',
        prefixItems: [
          { type: 'integer' },
          { type: 'string' }
        ]
      )
    end
  end
end
