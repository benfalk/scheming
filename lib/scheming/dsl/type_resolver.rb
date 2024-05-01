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
    def dto_type
      case self
      when :int, :integer then Scheming::Type::Integer.new
      when :str, :string then Scheming::Type::String.new
      when :float then Scheming::Type::Float.new
      when :bool then Scheming::Type::Boolean.new
      end
    end
  end

  refine Scheming::Type::Base do
    def dto_type = self
  end

  refine Array do
    def dto_type
      # TODO: Error Handling
      Scheming::Type::Array.new(first.dto_type)
    end
  end

  refine Scheming::DSL::ObjectTypeDef do
    def dto_type = self.class.dto_type
  end

  refine ::String.singleton_class do
    def dto_type = Constants::STRING
  end

  refine ::String do
    def dto_type = Constants::STRING
  end

  refine ::Float.singleton_class do
    def dto_type = Constants::FLOAT
  end

  refine ::Float do
    def dto_type = Constants::FLOAT
  end

  refine ::Integer.singleton_class do
    def dto_type = Constants::INTEGER
  end

  refine ::Integer do
    def dto_type = Constants::INTEGER
  end

  refine ::TrueClass do
    def dto_type = Constants::BOOLEAN
  end

  refine ::FalseClass do
    def dto_type = Constants::BOOLEAN
  end

  refine ::Set do
    def dto_type
      # TODO: Type checking of all values
      Scheming::Type::Enum.new(
        first.dto_type,
        values: dup.freeze
      )
    end
  end

  using self

  module_function

  def resolve(any) = any.dto_type
end
