# frozen_string_literal: true

LineItem = Scheming.object do
  attribute :id, Integer
  attribute :name, String
  attribute :taxable, :bool
  attribute :desc, Nullable(String)
  attribute :price, Float
  attribute :item_type, Enum('entertainment', 'staple')
end

Receipt = Scheming.object do
  attribute :line_items, Array(LineItem)
  attribute :total, Float
end

RSpec.describe do
  it do
    expect(Scheming::Schema.json(Receipt)).to eq(
      type: 'object',
      additionalProperties: false,
      required: %i[line_items total],
      properties: {
        line_items: {
          type: 'array',
          items: {
            type: 'object',
            additionalProperties: false,
            required: %i[id name taxable desc price item_type],
            properties: {
              id: { type: 'integer' },
              name: { type: 'string' },
              taxable: { type: 'boolean' },
              desc: {
                oneOf: [
                  { type: 'string' },
                  { type: 'null' }
                ]
              },
              price: { type: 'numeric' },
              item_type: {
                type: 'string',
                enum: %w[entertainment staple].to_set
              }
            }
          }
        },
        total: { type: 'numeric' }
      }
    )
  end
end
