class Item < ActiveRecord::Base
	has_and_belongs_to_many :shoppinglists, -> { uniq }

	scope :search, lambda {|query|
		where(["item_name LIKE ?", "%#{query}%"])
	}
end
