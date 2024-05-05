# frozen_string_literal: true

# This is a redundant require statement; however,
# for some reason Solargraph will not honor the
# path for `set` in it's config.  For this reson
# we need to require it here to prevent typecheck
# errors.
require 'set' # rubocop:disable Lint/RedundantRequireStatement

# = Type
#
# Everything needed to describe and work
# with defining types to encode to.
#
module Scheming::Type
  # = Base Type Definition
  #
  # Any and all shared functionality comes from
  # this base type definition.
  #
  class Base
    # This class left empty on purpose.  Acts
    # merely as a tag which all types inherit
    # back to.
  end

  # = Object Type Definition
  #
  # Holds any number of named fields and the
  # types that they hold
  #
  class Object < Base
    # @return [Scheming::Attribute::List]
    attr_reader :attributes

    # @param attributes [Scheming::Attribute::List]
    def initialize(attributes = Scheming::Attribute::List.empty)
      super()
      @attributes = attributes
      freeze
    end
  end

  # = Nullable Type Definition
  #
  # Type wrapper that describes a type can be either
  # the type provided OR it may be Null
  #
  class Nullable < Base
    # @return [Scheming::Type::Base]
    attr_reader :type

    # @param type [Scheming::Type::Base]
    def initialize(type)
      super()
      @type = type
      freeze
    end
  end

  # = Union Type Definition
  #
  # In cases where a value can be of many different
  # types a union is how to describe this.
  #
  class Union < Base
    # @return [Array<Scheming::Type::Base>]
    attr_reader :types

    # @param types [Array<Scheming::Type::Base>]
    def initialize(types)
      super()
      @types = types
      freeze
    end
  end

  # = Enumeration Type Definition
  #
  # The wrapper that describes a type and holds
  # a discrete set of values of that type.
  #
  class Enum < Base
    # @return [Scheming::Type::Base]
    attr_reader :type

    # @return [Set<Object>]
    attr_reader :values

    # @param type [Scheming::Type::Base]
    # @param values [Set<Object>]
    def initialize(type, values:)
      super()
      @type = type
      @values = values
      freeze
    end
  end

  # = Array Type Definition
  #
  # Type wrapper which describes an array of zero
  # or more of the provided type.
  #
  class Array < Base
    # @return [Scheming::Type::Base]
    attr_reader :type

    # @param type [Scheming::Type::Base]
    def initialize(type)
      super()
      @type = type
      freeze
    end
  end

  # = Integer Type Definition
  class Integer < Base; end

  # = Float Type Definition
  class Float < Base; end

  # = String Type Definition
  class String < Base; end

  # = Boolean Type Definition
  class Boolean < Base; end
end
