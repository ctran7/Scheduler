class Technician < ApplicationRecord
  has_many :workOrders, :foreign_key => "technician_id"
end
