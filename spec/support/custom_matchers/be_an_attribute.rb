# frozen_string_literal: true

RSpec::Matchers.define :be_an_attribute do
  chain :with_field_name do |field_name|
    field_checks.merge!(field_name:)
  end

  chain :that_is_required do
    field_checks.merge!(is_required: true)
  end

  chain :that_is_not_required do
    field_checks.merge!(is_required: false)
  end

  match do |actual|
    return false unless actual.is_a?(Scheming::Attribute)
    return false if field_errors(actual).any?

    true
  end

  failure_message do |actual|
    if actual.is_a?(Scheming::Attribute)
      field_errors(actual).join("\n")
    else
      <<~MSG
        Expected [Scheming::Attribute]
          Actual [#{actual.class.name}]
      MSG
    end
  end

  def field_checks = @field_checks ||= {}

  def field_errors(actual)
    field_checks.each_with_object([]) do |(field, expected_val), errs|
      actual_val = actual.send(field)
      errs << <<~MSG if actual_val != expected_val
        Field Mismatch [#{field}]
              Expected [#{expected_val}]
                Actual [#{actual_val}]
      MSG
    end
  end
end
