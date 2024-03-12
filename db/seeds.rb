# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Seed initial time slots
10.times do |n|
  start_time = Time.parse("08:00") + n.hours
  end_time = Time.parse("09:00") + n.hours

  Timeslots.create!(
    starttime: start_time.strftime("%H:%M"),
    endtime: end_time.strftime("%H:%M"),
    deleted_date: nil
  )
end
# Seed initial purposes
10.times do |n|
  Purposes.create!(
    name: "Purpose #{n+1}",
    description: "Description for purpose #{n+1}",
    criticality: "Criticality #{n+1}",
    make_year: "Year #{n+1}",
    brand: "Brand #{n+1}",
    deleted_date: nil
  )
end
