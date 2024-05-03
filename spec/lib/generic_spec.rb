# frozen_string_literal: true

RSpec.describe Scheming::Generic do
  it 'passes the simple point example' do
    point = described_class.new do |(type)|
      Object(x: type, y: type)
    end

    float_point = point[Float]

    expect(Scheming::Schema.json(float_point))
      .to be_valid_json_schema

    expect(Scheming::Schema.json(float_point))
      .to eq(
        type: 'object',
        additionalProperties: false,
        required: %i[x y],
        properties: {
          x: { type: 'number' },
          y: { type: 'number' }
        }
      )
  end

  it 'works with multiple types' do
    generic_cursor = described_class.new do |(key, type)|
      Object(
        left: Nullable(key),
        right: Nullable(key),
        value: type
      )
    end

    cursor = generic_cursor[String, Float]

    expect(Scheming::Schema.json(cursor))
      .to be_valid_json_schema

    expect(Scheming::Schema.json(cursor))
      .to eq(
        type: 'object',
        additionalProperties: false,
        required: %i[left right value],
        properties: {
          left: {
            oneOf: [
              { type: 'string' },
              { type: 'null' }
            ]
          },
          right: {
            oneOf: [
              { type: 'string' },
              { type: 'null' }
            ]
          },
          value: { type: 'number' }
        }
      )
  end
end
