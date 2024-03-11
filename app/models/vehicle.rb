class Vehicles < ApplicationRecord

  validates :make_year, format: { with: /\A\d{4}\z/, message: "Validation Error : Make Year must be a valid four-digit year" }

  validate :validate_date_format

#   Explicitly excluding the validations for the following params as out of scope
#       vin number - the regex will be built and verified upon
#       liscence_number number - the regex will be built and verified upon
#       vehicle_name and vehicle_brand - the name and brand will be stored in static tables for now and shown in the dropdown in UI.
#           The selected value in the UI which is received via params will be validated against the tables.

#   Insurance details is currently received as json and stored, on an expansion note, the insurance will be validated against policy from the policy check APIs (external APIs). Currently considering out of scope.


  private
  def validate_date_format
    [:purchased_date, :warranty_date].each do |attr|
      unless send(attr).is_a?(Date)
        errors.add(attr, "must be a valid date")
      end
    rescue ArgumentError
      errors.add(attr, "must be a valid date")
    end
  end
end
