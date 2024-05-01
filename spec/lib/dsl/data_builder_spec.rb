# frozen_string_literal: true

RSpec.describe Scheming::DSL::DataBuilder do
  let(:dto_class) do
    builder = described_class.new
    builder.attribute(:first_name, :string)
    builder.attribute(:aliases, [:string])
    builder.build
  end

  it do
    expect(dto_class).to be < Data

    expect(dto_class.dto_type)
      .to be_a(Scheming::Type::Object)

    expect(dto_class.dto_type).to be_frozen

    expect(Scheming::Schema.json(dto_class.dto_type))
      .to eq(
        type: 'object',
        additionalProperties: false,
        required: %i[first_name aliases],
        properties: {
          first_name: {
            type: 'string'
          },
          aliases: {
            type: 'array',
            items: {
              type: 'string'
            }
          }
        }
      )

    dto = dto_class.new(
      first_name: 'Peter',
      aliases: %w[Petey Pete]
    )

    expect(dto).to be_a(Data)
    expect(dto).to be_frozen
    expect(dto.first_name).to eq('Peter')
    expect(dto.aliases).to eq(%w[Petey Pete])
  end
end
