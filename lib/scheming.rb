# frozen_string_literal: true

require_relative 'scheming/version'

# = Scheming
#
module Scheming
  class Error < StandardError; end

  require_relative 'scheming/attribute'
  require_relative 'scheming/type'
  require_relative 'scheming/schema'
  require_relative 'scheming/generic'
  require_relative 'scheming/dsl'

  # @return [Class]
  def self.object(&)
    builder = Scheming::DSL::DataBuilder.new
    builder.instance_exec(&)
    builder.build
  end

  # @return [Scheming::Generic]
  def self.generic(&) = Scheming::Generic.new(&)
end
