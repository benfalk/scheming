## [Unreleased]

## [0.4.0] - 2024-05-02

### Breaking Change

- Opting for a `tag` system to work with attributes instead
  of a blanket lexical scope like `optional` to work with
  attributes.  The long term goal is to expand out the tagging
  system so that it can support much more than we can
  anticipate today.

  # Example:
  ```ruby
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

## [0.3.0] - 2024-05-01

### Bugfix

- JSON Schema for Float was `numeric` instead of `number`

- JSON Schema production of `Enum` **must** be an array

### Enhancement

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

- Ensure all types produce valid JSON Schema

## [0.1.0] - 2024-04-26

- Initial release
