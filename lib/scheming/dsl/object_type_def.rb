# frozen_string_literal: true

# = Object Definition Tag
#
# This serves as a tag for produced
# transformation object definitions.
#
module Scheming::DSL::ObjectTypeDef
  # @private
  module ClassMethods
    # @return [Scheming::Type::Object]
    def scheming_type = @scheming_type

    def inherited(klass)
      super
      klass.extend(ClassMethods)
      klass.instance_variable_set(
        :@scheming_type,
        scheming_type
      )
    end

    # @return [Class<Data>]
    def extend_with(&)
      list = Scheming::Attribute::ListBuilder.new(
        scheming_type.attributes.to_a
      )
      builder = Scheming::DSL::DataBuilder.new(list)
      builder.instance_exec(&)
      builder.build
    end
  end
  private_constant :ClassMethods

  def self.included(klass) = klass.extend(ClassMethods)
end
