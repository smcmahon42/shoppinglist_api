class User < ActiveRecord::Base
	has_secure_password
	
	has_and_belongs_to_many :groups, -> { uniq }
	# (Deprecated) has_and_belongs_to_many :groups, :uniq => true
end
