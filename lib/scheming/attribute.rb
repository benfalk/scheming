# frozen_string_literal: true

# = Attribute
#
class Scheming::Attribute
  # @return [Symbol]
  attr_reader :field_name

  # @return [Scheming::Type::Base]
  attr_reader :type

  # @return [Boolean]
  attr_reader :is_required

  # @param field_name [Symbol]
  # @param type [Scheming::Type::Base]
  def initialize(
    field_name:,
    type:,
    is_required: true
  )
    @field_name = field_name
    @type = type
    @is_required = is_required
    freeze
  end

  require_relative 'attribute/list'
  require_relative 'attribute/list_builder'
end
