# frozen_string_literal: true

module Scheming::Schema
  # @private
  module JSON
    module Constants
      NULL = { type: 'null' }.freeze
      INTEGER = { type: 'integer' }.freeze
      FLOAT = { type: 'number' }.freeze
      STRING = { type: 'string' }.freeze
      BOOLEAN = { type: 'boolean' }.freeze
    end
    private_constant :Constants

    refine Scheming::Type::Object do
      # @!attribute [r] attributes
      #   @return [Scheming::Attribute::List]

      # @return [Hash]
      def schema
        {
          type: 'object',
          additionalProperties: false,
          required:,
          properties:
        }.freeze
      end

      private

      def required
        attributes
          .required
          .map! { |attr| attr.field_name.to_s.freeze }
          .freeze
      end

      def properties
        attributes.to_h.transform_values do |attr|
          attr.type.schema
        end.freeze
      end
    end

    refine Scheming::Type::Nullable do
      # @!attribute [r] type
      #   @return [Scheming::Type::Base]

      # @return [Hash]
      def schema
        {
          oneOf: [
            type.schema,
            Constants::NULL
          ].freeze
        }.freeze
      end
    end

    refine Scheming::Type::Array do
      # @!attribute [r] type
      #   @return [Scheming::Type::Base]

      def schema
        {
          type: 'array',
          items: type.schema
        }.freeze
      end
    end

    refine Scheming::Type::Enum do
      def schema
        type.schema.merge(enum: values.to_a.freeze).freeze
      end
    end

    refine Scheming::Type::String do
      # @return [Hash]
      def schema = Constants::STRING
    end

    refine Scheming::Type::Integer do
      # @return [Hash]
      def schema = Constants::INTEGER
    end

    refine Scheming::Type::Float do
      # @return [Hash]
      def schema = Constants::FLOAT
    end

    refine Scheming::Type::Boolean do
      # @return [Hash]
      def schema = Constants::BOOLEAN
    end

    using self

    module_function

    # @param type [Scheming::Type::Base]
    # @return [Hash]
    def schema(type) = type.schema
  end
  private_constant :JSON
end
