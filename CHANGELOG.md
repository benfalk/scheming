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
