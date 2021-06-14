require 'csv'

namespace :csv_import do
  desc "Import technicians data"
  task technician_data: :environment do
    url = '/Users/cindytran/test_csv_app/csv_importer/technicians.csv'
    csv_string = open(url).read
      CSV.parse(csv_string, headers: true, header_converters: :symbol) do |row|
        technician_hash = row.to_hash
        technician = Technician.create(technician_hash)
      end
  end

  desc "Import location data"
  task location_data: :environment do
    url = '/Users/cindytran/test_csv_app/csv_importer/locations.csv'
    csv_string = open(url).read
      CSV.parse(csv_string, headers: true, header_converters: :symbol) do |row|
        location_hash = row.to_hash
        location = Location.create(location_hash)
      end
  end

  desc "Import work orders data"
  task work_orders_data: :environment do
    url = '/Users/cindytran/test_csv_app/csv_importer/work_orders.csv'
    csv_string = open(url).read
      CSV.parse(csv_string, headers: true, header_converters: :symbol) do |row|
        work_order_hash = row.to_hash
        work_order = WorkOrder.create(work_order_hash)
      end
  end
end
