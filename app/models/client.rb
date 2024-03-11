class Client < ApplicationRecord

  validates :client_firstname, :client_lastname, :client_phone, :client_email, :contact_concent presence: true

  validates :client_firstname, :client_lastname, format: { with: /\A[a-zA-Z]+\z/, message: "Validation error : Name must have alphabets only" }
  validates :client_phone, format: { with: /\A\d{10}\z/, message: "Validation error : Phone number must be a 10-digit number" }
  validates :client_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Validation error : Email ID is not in the expected format" }

  private

  def set_defaults
    self.contact_concent ||= false
  end
end
