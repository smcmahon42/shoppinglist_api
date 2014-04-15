class CreateItems < ActiveRecord::Migration
  
  def up
    create_table :items do |t|
    	t.string "item_name"
    	t.string "quantity"
	    t.timestamps
    end
  end

  def down
  	drop_table :items
  end

end
