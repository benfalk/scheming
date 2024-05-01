# frozen_string_literal: true

module Scheming
  # = Schema
  #
  # Responsible for producing different schema
  # formats which describe the data type provided
  # to it.
  #
  module Schema
    require_relative 'schema/json'

    module_function

    # @param raw_type [Scheming::Type::Base]
    # @return [Hash]
    def json(raw_type)
      type = Scheming::DSL::TypeResolver.resolve(raw_type)
      JSON.schema(type)
    end
  end
end
