# frozen_string_literal: true

RSpec::Matchers.define :be_valid_json_schema do
  match do |actual|
    JSONSchemer.valid_schema?(actual)
  end

  failure_message do |actual|
    JSONSchemer.validate_schema(actual).to_a.join("\n\n\n")
  end
end
