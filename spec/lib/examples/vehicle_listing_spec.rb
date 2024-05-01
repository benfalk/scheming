# frozen_string_literal: true

class PriceHistoryItem < Scheming.object \
  do
    # @!attribute [r] timestamp
    #   @return [Integer]
    attribute :timestamp, Integer

    # @!attribute [r] price
    #   @return [Float]
    attribute :price, Float
  end
end

class VehicleListing < Scheming.object \
  do
    # @!attribute [r] vin
    #   @return [String]
    attribute :vin, String

    # @!attribute [r] make_slug
    #   @return [String]
    attribute :make_slug, String

    # @!attribute [r] model_slug
    #   @return [String]
    attribute :model_slug, String

    # @!attribute [r] dealership_id
    #   @return [Integer]
    attribute :dealership_id, Integer

    # @!attribute [r] price
    #   @return [Float]
    attribute :price, Nullable(Float)

    # @!attribute [r] price_history
    #   @return [Array<PriceHistoryItem>]
    attribute :price_history, Array(PriceHistoryItem)

    # @!attribute [r] price_history
    #   @return ['red', 'green', 'blue', 'yellow']
    attribute :color, Enum('red', 'green', 'blue', 'yellow')
  end
end

RSpec.describe VehicleListing do
  # @!attribute subject [r]
  #   @return [VehicleListing]
  subject do
    described_class.new(
      vin: 'xxx',
      make_slug: 'ford',
      model_slug: 'f-150',
      dealership_id: 42,
      price: 4200.69,
      color: 'red',
      price_history: [
        PriceHistoryItem.new(timestamp: 0, price: 4199.99),
        PriceHistoryItem.new(timestamp: 1, price: 4200.69)
      ]
    )
  end

  let(:expected_json_schema) do
    {
      type: 'object',
      additionalProperties: false,
      required: %i[
        vin make_slug model_slug
        dealership_id price price_history
        color
      ],
      properties: {
        vin: { type: 'string' },
        make_slug: { type: 'string' },
        model_slug: { type: 'string' },
        dealership_id: { type: 'integer' },
        price: {
          oneOf: [
            { type: 'numeric' },
            { type: 'null' }
          ]
        },
        color: {
          type: 'string',
          enum: %w[red green blue yellow].to_set
        },
        price_history: {
          type: 'array',
          items: {
            type: 'object',
            additionalProperties: false,
            required: %i[timestamp price],
            properties: {
              timestamp: { type: 'integer' },
              price: { type: 'numeric' }
            }
          }
        }
      }
    }
  end

  it do
    expect(subject).to be_a(VehicleListing)
    expect(subject.vin).to eq('xxx')
    expect(subject.make_slug).to eq('ford')
    expect(subject.model_slug).to eq('f-150')
    expect(subject.dealership_id).to eq(42)
    expect(subject.price).to eq(4200.69)
    expect(subject.price_history).to eq(
      [
        PriceHistoryItem.new(timestamp: 0, price: 4199.99),
        PriceHistoryItem.new(timestamp: 1, price: 4200.69)
      ]
    )

    expect(Scheming::Schema.json(subject))
      .to eq(expected_json_schema)

    expect(Scheming::Schema.json(VehicleListing))
      .to eq(expected_json_schema)
  end
end
