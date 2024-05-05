# frozen_string_literal: true

# = Attribute Collection
#
class Scheming::Attribute::List
  class MissingAttribute < Scheming::Error; end
  include Enumerable

  # @return [Scheming::Attribute::List]
  def self.empty = @empty ||= new([])

  # @param attributes [Array<Scheming::Attribute>]
  def initialize(attributes = [])
    @attributes = attributes.uniq(&:field_name).freeze

    # @type [Hash<Symbol, Scheming::Attribute>]
    @lookup =
      @attributes
      .each_with_object({}) do |attr, lookup|
        lookup[attr.field_name] = attr
      end
      .freeze
    freeze
  end

  # @param key [Symbol]
  # @return [Scheming::Attribute]
  def attr(key)
    @lookup.fetch(key) do |attr_key|
      raise MissingAttribute, <<~MSG.strip!
        Missing Attribute [#{attr_key}]
        Available Fields:
          #{@attributes.map(&:field_name).join("\n  ")}
      MSG
    end
  end
  alias [] attr

  # @return [Array<Scheming::Attribute>]
  def required = each.select(&:is_required)

  # @return [Hash<Symbol, Scheming::Attribute>]
  def to_h = @lookup

  # Interface for Enumerable
  # @yieldparam [Scheming::Attribute]
  def each(&)
    return enum_for(:each) unless block_given?

    @attributes.each(&)
  end
end
