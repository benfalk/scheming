# frozen_string_literal: true

FactoryBot.define do
  factory :attribute, class: Scheming::Attribute do
    field_name { :first_name }
    is_required { true }
    type { build(:string_type) }

    trait :string do
      type { build(:string_type) }
    end

    trait :float do
      type { build(:float_type) }
    end

    trait :bool do
      type { build(:bool_type) }
    end

    trait :int do
      type { build(:int_type) }
    end

    initialize_with do
      new(**attributes)
    end
  end
end
