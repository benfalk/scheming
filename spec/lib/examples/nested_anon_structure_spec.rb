# frozen_string_literal: true

Scheming.object do
  attribute :first_name, String
  attribute :last_name, String

  attribute :address, Object(
    street1: String,
    street2: Nullable(String),
    city: String,
    state: String,
    zip: String
  )

  attribute :logs, Array(
    Object(
      timestamp: Integer,
      message: String
    )
  )
end
