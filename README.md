# Scheming

Ergonomically define and work with data in Ruby

## Installation

```ruby
gem 'scheming'
```

## Usage

### Simple Schema

Definition:
```ruby
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
```

Example:
```ruby
Scheming::Schema.json(Receipt)
# =>
{
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
}
```

## Development

### Getting Started

To get going the following commands are helpful:

```bash
git clone https://github.com/benfalk/scheming.git
./scheming/setup
cd scheming
bundle exec rake
```

### Installing Locally

To install this gem onto your local machine:

```bash
bundle exec rake install
```

## Contributing

Bug reports and pull requests are welcome
on GitHub at https://github.com/benfalk/scheming.

## License

The gem is available as open source under the terms of
the [MIT License](https://opensource.org/licenses/MIT).
