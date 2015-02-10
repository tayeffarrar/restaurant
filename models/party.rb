class Party < ActiveRecord::Base
	has_many :orders,  foreign_key: 'partyid'
  has_many :foods, through: :orders

  validates :table_name, uniqueness: true


def getreceipt
		total = 0
		orders = self.orders
		orders.each do |order|
			total += order.food.price.to_i * order.quantity.to_i
		end
		total
	end
end
