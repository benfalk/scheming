# frozen_string_literal: true

EmailTemplate = Scheming.object do
  attribute :id, Integer
  attribute :data, Tuple(String, Array(String))
end

RSpec.describe do
  it do
    expect(Scheming::Schema.json(EmailTemplate)).to eq(
      type: 'object',
      additionalProperties: false,
      required: %w[id data],
      properties: {
        id: { type: 'integer' },
        data: {
          type: 'array',
          prefixItems: [
            { type: 'string' },
            {
              type: 'array',
              items: { type: 'string' }
            }
          ]
        }
      }
    )
  end
end
