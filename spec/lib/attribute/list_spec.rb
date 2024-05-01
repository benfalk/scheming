# frozen_string_literal: true

RSpec.describe Scheming::Attribute::List do
  let(:attributes) { [] }
  let(:instance) { described_class.new(attributes) }

  it do
    expect(instance).to be_a(described_class)

    expect { instance.attr(:foo) }
      .to raise_error(
        Scheming::Attribute::List::MissingAttribute
      )

    expect { instance[:foo] }
      .to raise_error(
        Scheming::Attribute::List::MissingAttribute
      )
  end

  context 'with some attributes' do
    let(:first_name) { build(:attribute, :string, field_name: :first_name) }
    let(:last_name) { build(:attribute, :string, field_name: :last_name) }
    let(:attributes) { [first_name, last_name] }

    it do
      expect(instance).to be_a(described_class)
      expect(instance.attr(:first_name)).to be(first_name)
      expect(instance.attr(:last_name)).to be(last_name)
      expect(instance.to_a).to eq(attributes)
    end
  end
end
