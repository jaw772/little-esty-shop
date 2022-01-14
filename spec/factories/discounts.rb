FactoryBot.define do
  factory :discount do
    sequence(:name) { |n| "Default Discount Name #{n}" }
    sequence(:threshold_quantity) { |n| n * 5 }
    sequence(:discount_rate) { |n|  n * 0.10 }
    merchant
  end
end
