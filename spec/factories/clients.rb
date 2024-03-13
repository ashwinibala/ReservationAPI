FactoryBot.define do
  factory :client do
    name { 'John Doe' }
    phone { '1234567890' }
    email { 'john@example.com' }
    # Add other attributes as needed
  end
end
