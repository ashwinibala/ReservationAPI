# Seed initial time slots
10.times do |n|
  start_time = Time.parse("08:00") + n.hours
  end_time = Time.parse("09:00") + n.hours

  Timeslot.create!(
    starttime: start_time.strftime("%H:%M"),
    endtime: end_time.strftime("%H:%M"),
    deleted_date: nil
  )
end
# Seed initial purposes
10.times do |n|
  Purpose.create!(
    name: "Purpose #{n+1}",
    description: "Description for purpose #{n+1}",
    criticality: "Criticality #{n+1}",
    make_year: "Year #{n+1}",
    brand: "Brand #{n+1}",
    deleted_date: nil
  )
end
