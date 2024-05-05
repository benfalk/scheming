## [Unreleased]

### Enhancement

- Added `solorgraph` to the development process and added
  it's typecheck to the default `rake` task.

- Reduced string allocations when generating required field
  names for objects with the JSON schema format.

### Bugfix

- Incorrect type syntax corrected as reported by `solargraph`.

## [0.6.0] - 2024-05-04

### Added

- `Union` type added

  #### Example
  ```ruby
  Order = Scheming.object do
    attribute :id, Union(String, Integer)
  end

  Scheming::Schema.json(Order)
  # =>
  {
    type: 'object',
    additionalProperties: false,
    required: %w[id],
    properties: {
      id: {
        oneOf: [
          { type: 'string' },
          { type: 'integer' }
        ]
      }
    }
  }
  ```

### Fixed

- Incorrect YARD comment tags and syntax.

### Breaking Change

- Switch from `json-schema` to `json_schemer`

  > TL;DR
    required object properties for the JSON schema
    are now strings instead of symbols

  After doing to research I've found that `json_schemer` is
  more maintained than what was currently being used.  It has
  a smaller footprint and is much faster at validation.

  As a consequence the `required` properties needed to be
  changed from symbols to strings in the generated JSON schema.


## [0.5.0] - 2024-05-02

### Added

- Support for `generic` definitions

  #### Example
  ```ruby
  Point = Scheming.generic do |(type)|
    Object(x: type, y: type)
  end

  Scheming::Schema.json(Point)
  # =>
  {
    type: 'object',
    additionalProperties: false,
    required: %i[x y],
    properties: {
      x: { type: 'number' },
      y: { type: 'number' }
    }
  }
  ```

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

- Ensure all types produce valid JSON Schema

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

## [0.1.0] - 2024-04-26

- Initial release
