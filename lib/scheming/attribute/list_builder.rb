# frozen_string_literal: true

# = Attribute Collection Builder
#
class Scheming::Attribute::ListBuilder
  # @param attributes [Array<Scheming::Attribute>]
  def initialize(attributes = [])
    @attributes = attributes
    freeze
  end

  # @param field_name [Symbol]
  # @param type [Scheming::Type::Base]
  # @return [Scheming::Attribute::ListBuilder]
  def attribute(field_name, type:, is_required: true)
    attr = Scheming::Attribute.new(
      field_name:,
      type:,
      is_required:
    )
    self.class.new(@attributes + [attr])
  end

  # @return [Scheming::Attribute::List]
  def build = Scheming::Attribute::List.new(@attributes)
end
