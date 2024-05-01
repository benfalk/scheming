# frozen_string_literal: true

using Scheming::DSL::TypeResolver

RSpec.describe Scheming::Attribute::ListBuilder do
  # @!attribute [r] builder
  #   @return [Scheming::Attribute::ListBuilder]
  let(:builder) { described_class.new }

  shared_examples_for 'a list with single attr' do |name, type|
    it do
      is_expected.to be_a(Scheming::Attribute::List)

      expect(subject.count).to eq(1)

      expect(subject[name])
        .to be_an_attribute
        .with_field_name(name)
        .that_is_required

      expect(subject[name].type).to be_a(type)
    end
  end

  shared_examples_for 'a list with a nullable attr' do |name, type|
    it_behaves_like 'a list with single attr',
                    name, Scheming::Type::Nullable
    it { expect(subject[name].type.type).to be_a(type) }
  end

  subject do
    builder.attribute(field_name, type: type_spec.dto_type).build
  end

  context 'empty' do
    subject { builder.build }
    it do
      is_expected.to be_a(Scheming::Attribute::List)
      is_expected.to be_none
    end
  end

  context 'single string field' do
    let(:field_name) { :first_name }
    let(:type_spec) { String }
    it_behaves_like 'a list with single attr',
                    :first_name, Scheming::Type::String
  end

  context 'single float field' do
    let(:field_name) { :price }
    let(:type_spec) { Float }
    it_behaves_like 'a list with single attr',
                    :price, Scheming::Type::Float
  end

  context 'single integer field' do
    let(:field_name) { :age }
    let(:type_spec) { Integer }
    it_behaves_like 'a list with single attr',
                    :age, Scheming::Type::Integer
  end

  context 'single boolean field' do
    let(:field_name) { :enabled }
    let(:type_spec) { :bool }
    it_behaves_like 'a list with single attr',
                    :enabled, Scheming::Type::Boolean
  end

  context 'single nullable string field' do
    let(:field_name) { :first_name }
    let(:type_spec) { Nullable(String) }
    it_behaves_like 'a list with a nullable attr',
                    :first_name, Scheming::Type::String
  end

  context 'single nullable float field' do
    let(:field_name) { :price }
    let(:type_spec) { Nullable(Float) }
    it_behaves_like 'a list with a nullable attr',
                    :price, Scheming::Type::Float
  end

  context 'single nullable integer field' do
    let(:field_name) { :count }
    let(:type_spec) { Nullable(Integer) }
    it_behaves_like 'a list with a nullable attr',
                    :count, Scheming::Type::Integer
  end

  context 'single nullable boolean field' do
    let(:field_name) { :success }
    let(:type_spec) { Nullable(:bool) }
    it_behaves_like 'a list with a nullable attr',
                    :success, Scheming::Type::Boolean
  end

  context 'single nullable array field' do
    let(:field_name) { :scores }
    let(:type_spec) { Nullable(Array(Float)) }
    it_behaves_like 'a list with a nullable attr',
                    :scores, Scheming::Type::Array
    it do
      # Nullable > Array > Float
      expect(subject[:scores].type.type.type)
        .to be_a(Scheming::Type::Float)
    end
  end

  context 'single array field' do
    let(:field_name) { :names }
    let(:type_spec) { Array(String) }
    it_behaves_like 'a list with single attr',
                    :names, Scheming::Type::Array
    it do
      expect(subject[:names].type.type)
        .to be_a(Scheming::Type::String)
    end
  end

  context 'single object field' do
    let(:field_name) { :address }
    let(:type_spec) { Object(state: String, zip: String) }
    let(:address_attributes) do
      subject[:address].type.attributes
    end
    it_behaves_like 'a list with single attr',
                    :address, Scheming::Type::Object
    it do
      expect(address_attributes.count).to eq(2)

      expect(address_attributes[:state].type)
        .to be_a(Scheming::Type::String)

      expect(address_attributes[:zip].type)
        .to be_a(Scheming::Type::String)
    end
  end
end
