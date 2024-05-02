# frozen_string_literal: true

RSpec.describe Scheming::DSL::Tagging do
  describe '#attribute_params' do
    it do
      tagging = described_class.new
      expect(tagging.attribute_params).to eq(is_required: true)

      tagging.tag!(:optional, {})
      expect(tagging.attribute_params).to eq(is_required: false)

      tagging.reset!
      expect(tagging.attribute_params).to eq(is_required: true)
    end
  end
end
