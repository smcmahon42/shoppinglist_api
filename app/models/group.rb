class Group < ActiveRecord::Base
	has_many :shoppinglists
	has_and_belongs_to_many :users, -> { uniq }
	#has_and_belongs_to_many :users, :uniq => true
end
