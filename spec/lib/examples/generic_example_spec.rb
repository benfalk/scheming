# frozen_string_literal: true

Event = Scheming.generic do |(subject, data)|
  Object(
    subject:,
    data:,
    event_key: String,
    seq_no: Integer
  )
end

SubjectB = Scheming.object do
  attribute :id, String
  attribute :consumer_id, String
end

SubjectA = Scheming.object do
  attribute :id, Integer
  attribute :colors, Array(String)
end

BaseData = Scheming.object do
  attribute :created_at, Integer
end

EventA = Event[SubjectA, BaseData]
EventB = Event[SubjectB, BaseData]

RSpec.describe do
  it do
    expect(Scheming::Schema.json(EventA)).to eq(
      type: 'object',
      additionalProperties: false,
      required: %w[subject data event_key seq_no],
      properties: {
        subject: {
          type: 'object',
          additionalProperties: false,
          required: %w[id colors],
          properties: {
            id: { type: 'integer' },
            colors: {
              type: 'array',
              items: { type: 'string' }
            }
          }
        },
        data: {
          type: 'object',
          additionalProperties: false,
          required: %w[created_at],
          properties: {
            created_at: { type: 'integer' }
          }
        },
        event_key: { type: 'string' },
        seq_no: { type: 'integer' }
      }
    )

    expect(Scheming::Schema.json(EventB)).to eq(
      type: 'object',
      additionalProperties: false,
      required: %w[subject data event_key seq_no],
      properties: {
        subject: {
          type: 'object',
          additionalProperties: false,
          required: %w[id consumer_id],
          properties: {
            id: { type: 'string' },
            consumer_id: { type: 'string' }
          }
        },
        data: {
          type: 'object',
          additionalProperties: false,
          required: %w[created_at],
          properties: {
            created_at: { type: 'integer' }
          }
        },
        event_key: { type: 'string' },
        seq_no: { type: 'integer' }
      }
    )
  end
end
