# frozen_string_literal: true

# = Type Resolver
class Scheming::DSL::Tagging
  # = Attribute Tag
  #
  # Simple representation of a concept
  # that can be used to aid in the
  # creation of an [Scheming::Attribute]
  #
  class Tag
    # @param name [Symbo]
    # @param data [Hash<Symbol, Object>]
    def initialize(name, data)
      @name = name
      @data = data
    end
  end
  private_constant :Tag

  def initialize
    # @type [Hash<Symbol, Tag>]
    @tags = {}
  end

  # @return [void]
  def reset!
    @tags.clear
    nil
  end

  # @param name [Symbol]
  # @param data [Hash<Symbol, Object>]
  # @return [Tag]
  def tag!(name, data)
    @tags[name] = Tag.new(name, data)
  end

  def attribute_params
    {
      is_required: missing?(:optional)
    }
  end

  def missing?(name) = !has?(name)
  def has?(name) = @tags.key?(name)
end
