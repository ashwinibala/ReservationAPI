class Schedule < ApplicationRecord
  validates :service_date, :timeslot_id, :purpose_id, :vehicle_id, presence: true

  validate :validate_date_format

#   timeslot_id and purpose_id will be receieved from the dropdows which populates from the timeslot and purpose tables. So it will be verified with the table values later. Currently considering out of scope.
#   The assumption is bookings are taken for only 2 months from current date. So, UI receives dates for date picker from DateAvailability table.
      # If the datecounter has more than threshold number of vehicles say 50 (which will be set in the dateavailability index), the date will be greyed out in the date picker.
      # Additional validation can be added for service_date to check the date is still available as per DateAvailability table.

  private
  def validate_date_format
    [:service_date].each do |attr|
      unless send(attr).is_a?(Date)
        errors.add(attr, "must be a valid date")
      end
    rescue ArgumentError
      errors.add(attr, "must be a valid date")
    end
  end
end
