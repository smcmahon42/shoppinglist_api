class CreateGroups < ActiveRecord::Migration

  def up
    create_table :groups do |t|
    	t.string "group_name"
    	t.boolean "private", :default => true
      t.timestamps 
    end
  end

  def down
      drop_table :groups
  end

end
