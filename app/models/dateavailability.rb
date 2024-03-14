class Dateavailability < ApplicationRecord
  validates :service_date, :timeslot_id, :vehicle_count, presence: true

  validate :validate_date_format

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
