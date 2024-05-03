# frozen_string_literal: true

# = Generic
#
# Many types can be "templated" in a way where
# some types get swapped in and out.  Perhaps
# the most common example for this is with a
# two dimensional `Point` structure. We could
# have a point with `Float` coordinates OR they
# could also be `Integer`:
#
# ```ruby
# Object(x: Float, y: Float)
# Object(x: Integer, y: Integer)
# ```
#
# Instead of having two defintions we can have
# a single generic that defins both:
#
# ```ruby
# Point = Scheming::Generic.new do |(t)|
#   Object(x: t, y: t)
# end
#
# Point[Float]
#
# Point[Integer]
# ```
#
class Scheming::Generic
  def initialize(&proto_type)
    @proto_type = proto_type
  end

  # @param types [Scheming::Type::Base]
  def [](*types)
    Scheming::DSL::DataBuilder
      .new
      .instance_exec(types, &@proto_type)
  end
end
