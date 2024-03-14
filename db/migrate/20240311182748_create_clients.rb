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

    create_table :vehicles do |t| # vehicle information is stored in this table
      t.string :vin # vehicle identification number
      t.string :brand
      t.string :name
      t.string :licence_number
      t.string :make_year
      t.string :insurance_details # this can be either a json or for scalability and normalization a separate table can be used
      t.date :purchased_date
      t.date :warrenty_date
      t.references :client, foreign_key: { to_table: :clients }
      t.timestamps
    end

    create_table :schedules do |t| # the service schedule is stored in this table
      t.date :service_date
      t.date :completed_date
      t.string :purpose
      t.references :vehicle, foreign_key: { to_table: :vehicles }
      t.references :timeslot, foreign_key: { to_table: :timeslots }
      t.timestamps
    end

    create_table :dateavailabilities do |t| # the Date Availability depicts the number of vehicles admitted per date.
      # The assumption is bookings are taken for only 2 months from current date. So, UI receives dates for date picker from this table.
      # If the datecounter has more than threshold number of vehicles say 50 (which will be set in the dateavailability index), the date will be greyed out in the date picker.
      t.date :service_date
      t.integer :vehicle_count
      t.references :timeslot, foreign_key: { to_table: :timeslots }
      t.timestamps
    end

     # Add uniqueness constraints
     add_index :clients, :phone, unique: true
     add_index :clients, :email, unique: true
     add_index :vehicles, :vin, unique: true
     add_index :vehicles, :licence_number, unique: true

  end
end
