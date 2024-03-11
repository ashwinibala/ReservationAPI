# app/form_objects/schedule_form.rb
class ScheduleForm
  include ActiveModel::Model

  attr_accessor :client_firstname, :client_lastname, :client_phone, :client_email, :contact_concent,
                :vin_id, :vehicle_brand, :vehicle_name, :licence_number, :make_year, :purchased_date, :warrenty_date, :insurance_details,
                :service_date, :time_slot_id, :purpose_id

  validates :client_firstname, :client_lastname, :client_phone, :client_email, :contact_concent,
  :vin_id, :vehicle_brand, :vehicle_name, :licence_number, :make_year, :purchased_date, :warrenty_date, :insurance_details,
  :service_date, :time_slot_id, :purpose_id presence: true
  validates :client_firstname, :client_lastname, format: { with: /\A[a-zA-Z]+\z/, message: "Validation error : Name must have alphabets only" }
  validates :client_phone, format: { with: /\A\d{10}\z/, message: "Validation error : Phone number must be a 10-digit number" }
  validates :client_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Validation error : Email ID is not in the expected format" }
  validates :make_year, format: { with: /\A\d{4}\z/, message: "Validation Error : Make Year must be a valid four-digit year" }
  validate :validate_date_format

#   Explicitly excluding the validations for the following params as out of scope
#       vin number - the regex will be built and verified upon
#       liscence_number number - the regex will be built and verified upon
#       vehicle_name and vehicle_brand - the name and brand will be stored in static tables for now and shown in the dropdown in UI. 
#           The selected value in the UI which is received via params will be validated against the tables.

#   Insurance details is currently received as json and stored, on an expansion note, the insurance will be validated against policy from the policy check APIs (external APIs). Currently considering out of scope.
#   timeslot_id and purpose_id will be receieved from the dropdows which populates from the timeslot and purpose tables. So it will be verified with the table values later. Currently considering out of scope.
#   The assumption is bookings are taken for only 2 months from current date. So, UI receives dates for date picker from DateAvailability table.
      # If the datecounter has more than threshold number of vehicles say 50 (which will be set in the dateavailability index), the date will be greyed out in the date picker.
      # Additional validation can be added for service_date to check the date is still available as per DateAvailability table.



  def initialize(attributes = {})
    super
    set_defaults
  end

  def save
    return false unless valid?

    schedule = Schedule.new(
      
    )
    schedule.save
  end

  private

  def set_defaults
    self.contact_concent ||= false
  end

  def validate_date_format
    [:purchased_date, :warranty_date,:service_date].each do |attr|
      unless send(attr).is_a?(Date)
        errors.add(attr, "must be a valid date")
      end
    rescue ArgumentError
      errors.add(attr, "must be a valid date")
    end
  end
end