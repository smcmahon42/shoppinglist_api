class Shoppinglist < ActiveRecord::Base
	has_and_belongs_to_many :items, -> { uniq }
end
