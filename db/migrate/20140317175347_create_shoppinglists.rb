class CreateShoppinglists < ActiveRecord::Migration
  
  def up
    create_table :shoppinglists do |t|
    	t.integer "group_id"
    	t.string "list_name"
      	t.timestamps
    end
    add_index("shoppinglists", "group_id")
  end

  def down
  	drop_table :shoppinglists
  end

end
