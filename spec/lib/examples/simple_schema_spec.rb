# frozen_string_literal: true

LineItem = Scheming.object do
  attribute :id, Union(Integer, String)
  attribute :name, String
  attribute :taxable, :bool
  attribute :price, Float

  tag(:optional)
  attribute :desc, Nullable(String)

  tag(:optional)
  attribute :item_type, Enum('entertainment', 'staple')
end

Point = Scheming.generic do |(type)|
  Object(x: type, y: type)
end

Receipt = Scheming.object do
  attribute :line_items, Array(LineItem)
  attribute :total, Float
  attribute :location, Point[Float]
end

RSpec.describe do
  it do
    expect(Scheming::Schema.json(Receipt)).to eq(
      type: 'object',
      additionalProperties: false,
      required: %w[line_items total location],
      properties: {
        line_items: {
          type: 'array',
          items: {
            type: 'object',
            additionalProperties: false,
            required: %w[id name taxable price],
            properties: {
              id: {
                oneOf: [
                  { type: 'integer' },
                  { type: 'string' }
                ]
              },
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
        total: { type: 'number' },
        location: {
          type: 'object',
          additionalProperties: false,
          required: %w[x y],
          properties: {
            x: { type: 'number' },
            y: { type: 'number' }
          }
        }
      }
    )
  end
end
