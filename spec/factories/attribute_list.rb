# frozen_string_literal: true

FactoryBot.define do
  factory :attribute_list, class: Scheming::Attribute::List do
    attrs { [] }
    initialize_with { new(attrs) }

    trait :snippet do
      attrs do
        [
          build(:attribute, :int, field_name: :id),
          build(:attribute, :string, field_name: :title),
          build(:attribute, :string, field_name: :summary),
          build(
            :attribute,
            type: build(:array_type, :string),
            field_name: :categories
          )
        ]
      end
    end
  end
end
