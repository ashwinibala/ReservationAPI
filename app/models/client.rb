class Client < ApplicationRecord

  has_many :vehicles, dependent: :destroy

  validates :firstname, :lastname, :phone, :email, :contact_concent, presence: true

  validates :firstname, :lastname, format: { with: /\A[a-zA-Z]+\z/, message: "Validation error : Name must have alphabets only" }
  validates :phone, format: { with: /\A\d{10}\z/, message: "Validation error : Phone number must be a 10-digit number" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Validation error : Email ID is not in the expected format" }

  private

  def set_defaults
    self.contact_concent ||= false
  end
end
