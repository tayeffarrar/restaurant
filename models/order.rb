class Order < ActiveRecord::Base
  belongs_to :parties
  has_many :foods, through: :orders 
end