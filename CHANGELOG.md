## [Unreleased]

## [0.1.0] - 2024-04-26

- Initial release

## [0.2.0] - 2024-05-01

### Added

- Support for `optional` fields

  # Example:
  ```ruby
  LineItem = Scheming.object do
    attribute :id, Integer
    attribute :name, String
    attribute :taxable, :bool
    attribute :price, Float

    optional

    attribute :desc, Nullable(String)
    attribute :item_type, Enum('entertainment', 'staple')
  end
  ```

## [0.3.0] - 2024-05-01

### Bugfix

- JSON Schema for Float was `numeric` instead of `number`

- JSON Schema production of `Enum` **must** be an array

### Enhancement

- Ensure all types produce valid JSON Schema
