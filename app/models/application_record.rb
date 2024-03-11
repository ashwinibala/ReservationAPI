class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_save :set_dates

  private

  def set_dates
    self.created_date ||= Date.today if new_record?
    self.updated_date = Date.today
  end
end
