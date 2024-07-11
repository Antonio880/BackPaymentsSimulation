FactoryBot.define do
  factory :pix_transaction do
    pix_key { "MyString" }
    amount { "9.99" }
    scheduled_at { "2024-06-13 15:51:55" }
    status { "MyString" }
  end
end
