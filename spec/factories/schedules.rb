# spec/factories/schedules.rb

FactoryBot.define do
  factory :schedule do
    service_date { Date.today }
    timeslot_id { 1 }
    purpose { 'Some purpose' }
  end
end
