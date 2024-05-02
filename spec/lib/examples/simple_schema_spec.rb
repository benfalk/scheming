# frozen_string_literal: true

LineItem = Scheming.object do
  attribute :id, Integer
  attribute :name, String
  attribute :taxable, :bool
  attribute :price, Float

  tag(:optional)
  attribute :desc, Nullable(String)

  tag(:optional)
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
            required: %i[id name taxable price],
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
              price: { type: 'number' },
              item_type: {
                type: 'string',
                enum: %w[entertainment staple]
              }
            }
          }
        },
        total: { type: 'number' }
      }
    )
  end
end
