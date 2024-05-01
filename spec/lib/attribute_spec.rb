# frozen_string_literal: true

RSpec.describe Scheming::Attribute do
  let(:type) { Scheming::Type::String.new }
  let(:is_required) { true }
  let(:field_name) { :first_name }
  let(:instance) do
    described_class.new(field_name:, type:, is_required:)
  end

  it do
    expect(instance).to be_a(described_class)
    expect(instance.type).to be(type)
    expect(instance.is_required).to be(true)
    expect(instance.field_name).to be(field_name)
    expect(instance).to be_frozen
  end
end
