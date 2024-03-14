# Seed initial time slots
  start_time1 = Time.parse("09:00")
  end_time1 = Time.parse("12:00")
  start_time2 = Time.parse("13:00")
  end_time2 = Time.parse("17:00")
  Timeslot.create!(
    starttime: start_time1.strftime("%H:%M"),
    endtime: end_time1.strftime("%H:%M"),
    deleted_date: nil
  )
  Timeslot.create!(
    starttime: start_time2.strftime("%H:%M"),
    endtime: end_time2.strftime("%H:%M"),
    deleted_date: nil
  )
