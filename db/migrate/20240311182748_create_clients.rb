class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t| # the client's personal information is stored in this table
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.boolean :contact_concent # concent for further contact
      t.timestamps
    end

    create_table :timeslots do |t| # the vehicle schedule timeslots - more of a static table
      t.string :starttime
      t.string :endtime
      t.date :deleted_date # incase a partcular time slot is not necessary at some point soft delete helps
      t.timestamps
    end

    create_table :purposes do |t| # the reasons for servicing the vehicle is stored in this table
      t.string :name
      t.string :description
      t.string :criticality
      t.string :make_year
      t.string :brand
      t.date :deleted_date # if the purpose is not applicable in a current scenario, it can be soft-deleted
      t.timestamps
    end

    create_table :vehicles do |t| # vehicle information is stored in this table
      t.string :vin # vehicle identification number
      t.string :brand
      t.string :name
      t.string :licence_number
      t.string :make_year
      t.string :insurance_details # this can be either a json or for scalability and normalization a separate table can be used
      t.date :purchased_date
      t.date :warrenty_date
      t.references :clients, foreign_key: true
      t.timestamps
    end

    create_table :schedules do |t| # the service schedule is stored in this table
      t.date :service_date
      t.date :completed_date
      t.references :vehicles, foreign_key: true
      t.references :timeslots, foreign_key: true
      t.references :purposes, foreign_key: true
      t.timestamps
    end

    create_table :DateAvailability do |t| # the Date Availability depicts the number of vehicles admitted per date.
      # The assumption is bookings are taken for only 2 months from current date. So, UI receives dates for date picker from this table.
      # If the datecounter has more than threshold number of vehicles say 50 (which will be set in the dateavailability index), the date will be greyed out in the date picker.
      t.date :service_date
      t.timestamps
    end

     # Add uniqueness constraints
     add_index :clients, :phone, unique: true
     add_index :clients, :email, unique: true

  end
end
