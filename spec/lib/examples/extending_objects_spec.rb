# frozen_string_literal: true

Summary = Scheming.object do
  attribute :title, String
  attribute :intro, String
end

Detail = Summary.extend_with do
  attribute :body, String
end

RSpec.describe 'Summary and Detail' do
  let(:expected_summary_schema) do
    {
      type: 'object',
      additionalProperties: false,
      required: %i[title intro],
      properties: {
        title: { type: 'string' },
        intro: { type: 'string' }
      }
    }
  end

  let(:expected_detail_schema) do
    {
      type: 'object',
      additionalProperties: false,
      required: %i[title intro body],
      properties: {
        title: { type: 'string' },
        intro: { type: 'string' },
        body: { type: 'string' }
      }
    }
  end

  let(:summary) do
    Summary.new(title: 'yo', intro: 'whats up')
  end

  let(:detail) do
    Detail.new(title: 'hey', intro: '3 things..', body: '....')
  end

  it do
    expect(summary).to be_a(Data)
    expect(summary.title).to eq('yo')
    expect(summary.intro).to eq('whats up')

    expect(detail).to be_a(Data)
    expect(detail.title).to eq('hey')
    expect(detail.intro).to eq('3 things..')
    expect(detail.body).to eq('....')

    expect(Scheming::Schema.json(summary))
      .to eq(expected_summary_schema)

    expect(Scheming::Schema.json(Summary))
      .to eq(expected_summary_schema)

    expect(Scheming::Schema.json(detail))
      .to eq(expected_detail_schema)

    expect(Scheming::Schema.json(Detail))
      .to eq(expected_detail_schema)
  end
end
