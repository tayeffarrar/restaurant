class Order < ActiveRecord::Base
  belongs_to :party, foreign_key: 'partyid'
  belongs_to :food, foreign_key: 'foodid'
end