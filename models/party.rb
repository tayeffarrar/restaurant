class Party < ActiveRecord::Base
	has_many :orders
  has_many :foods, through: :orders


def getreceipt
		total = 0
		orders = self.orders
		orders.each do |order|
			total += order.food.price.to_i * order.quantity.to_i
		end
		total
	end
end
