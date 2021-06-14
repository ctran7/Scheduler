class Location < ApplicationRecord
  has_many :workOrders, :foreign_key => "location_id"
end
