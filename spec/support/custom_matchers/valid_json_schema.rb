# frozen_string_literal: true

SCHEMA_VALIDATION =
  JSON::Validator
  .validator_for_name('draft6')
  .metaschema
  .freeze

RSpec::Matchers.define :be_valid_json_schema do
  match do |actual|
    JSON::Validator.validate(SCHEMA_VALIDATION, actual)
  end

  failure_message do |actual|
    "shits broke: #{actual}"
  end
end
