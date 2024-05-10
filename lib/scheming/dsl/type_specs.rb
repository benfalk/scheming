# frozen_string_literal: true

# = Type Specifications
#
# These helpers allow for a more ergonomic
# resolution of types
#
module Scheming::DSL::TypeSpecs
  def Enum(*values) # rubocop:disable Naming/MethodName
    Scheming::DSL::TypeResolver.resolve(values.to_set)
  end

  def Object(**attributes) # rubocop:disable Naming/MethodName
    attrs = attributes.map do |field_name, type_spec|
      Scheming::Attribute.new(
        field_name:,
        type: Scheming::DSL::TypeResolver.resolve(type_spec),
        is_required: true
      )
    end
    list = Scheming::Attribute::List.new(attrs)
    Scheming::Type::Object.new(list)
  end

  def Nullable(type_spec) # rubocop:disable Naming/MethodName
    type = Scheming::DSL::TypeResolver.resolve(type_spec)
    Scheming::Type::Nullable.new(type)
  end

  def Union(*type_specs) # rubocop:disable Naming/MethodName
    types = type_specs.map do |type_spec|
      Scheming::DSL::TypeResolver.resolve(type_spec)
    end
    Scheming::Type::Union.new(types)
  end

  def Tuple(*type_specs) # rubocop:disable Naming/MethodName
    types = type_specs.map do |type_spec|
      Scheming::DSL::TypeResolver.resolve(type_spec)
    end
    Scheming::Type::Tuple.new(types.freeze)
  end
end
