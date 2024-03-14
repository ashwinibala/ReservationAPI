# README

This README would normally document whatever steps are necessary to get the
application up and running.


* The Database configured in database.yml is MicrosoftSQL. Please feel free to connect the desired DB adaptor.

* Commands to bring up DB
* rails db:create
* rails db:migrate
* RAILS_ENV=test bin/rails db:migrate
* rails db:seed
* RAILS_ENV=test bin/rails db:seed

* To bring up rails server
* rails s / rails server

* APIs

* POST API

* http://localhost:3000/schedules
* RequestBody
* {
*  "client_firstname": "John",
*  "client_lastname": "Doe",
*  "client_phone": "1234567890",
*  "client_email": "john@example.com",
*  "contact_concent": true,
*  "vin": "ABC123XYZ45678965",
*  "vehicle_brand": "Toyota",
*  "vehicle_name": "Camry",
*  "licence_number": "ABC123",
*  "make_year": "2020",
*  "purchased_date": "2022-01-01",
*  "warrenty_date": "2025-01-01",
*  "insurance_details": "Some insurance details",
*  "service_date": "2024-03-15",
*  "timeslots_id": 1,
*  "purpose": "Air filter recall"
*}
