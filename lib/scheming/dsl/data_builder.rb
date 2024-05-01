# frozen_string_literal: true

# = Data Builder
class Scheming::DSL::DataBuilder
  include Scheming::DSL::TypeSpecs

  def initialize(builder = Scheming::Attribute::ListBuilder.new)
    @builder = builder
    @resolver = Scheming::DSL::TypeResolver
  end

  # @param field_name [Symbol]
  # @param type_spec [Object]
  # @param null [Boolean]
  # @return [void]
  def attribute(field_name, type_spec)
    type = @resolver.resolve(type_spec)
    @builder = @builder.attribute(field_name, type:)
    nil
  end

  # @return [Class]
  def build
    list = @builder.build
    dto_type = Scheming::Type::Object.new(list)

    data = ::Data.define(*list.map(&:field_name))
    data.instance_variable_set(:@dto_type, dto_type)
    data.include(Scheming::DSL::ObjectTypeDef)
    data
  end
end
