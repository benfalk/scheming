# frozen_string_literal: true

# = Type Resolver
module Scheming::DSL::TypeResolver
  module Constants
    STRING = Scheming::Type::String.new.freeze
    FLOAT = Scheming::Type::Float.new.freeze
    INTEGER = Scheming::Type::Integer.new.freeze
    BOOLEAN = Scheming::Type::Boolean.new.freeze
  end
  private_constant :Constants

  refine Kernel do
    import_methods Scheming::DSL::TypeSpecs
  end

  refine Symbol do
    def scheming_type
      case self
      when :int, :integer then Scheming::Type::Integer.new
      when :str, :string then Scheming::Type::String.new
      when :float then Scheming::Type::Float.new
      when :bool then Scheming::Type::Boolean.new
      end
    end
  end

  refine Scheming::Type::Base do
    def scheming_type = self
  end

  refine Array do
    def scheming_type
      # TODO: Error Handling
      Scheming::Type::Array.new(first.scheming_type)
    end
  end

  refine Scheming::DSL::ObjectTypeDef do
    def scheming_type = self.class.scheming_type
  end

  refine ::String.singleton_class do
    def scheming_type = Constants::STRING
  end

  refine ::String do
    def scheming_type = Constants::STRING
  end

  refine ::Float.singleton_class do
    def scheming_type = Constants::FLOAT
  end

  refine ::Float do
    def scheming_type = Constants::FLOAT
  end

  refine ::Integer.singleton_class do
    def scheming_type = Constants::INTEGER
  end

  refine ::Integer do
    def scheming_type = Constants::INTEGER
  end

  refine ::TrueClass do
    def scheming_type = Constants::BOOLEAN
  end

  refine ::FalseClass do
    def scheming_type = Constants::BOOLEAN
  end

  refine ::Set do
    def scheming_type
      # TODO: Type checking of all values
      Scheming::Type::Enum.new(
        first.scheming_type,
        values: dup.freeze
      )
    end
  end

  using self

  module_function

  def resolve(any) = any.scheming_type
end
