class CreateItemsShoppinglistsJoin < ActiveRecord::Migration

  def up
    create_table :items_shoppinglists, :id => false do |t|
    	t.references "item"
    	t.references "shoppinglist"
    end
    add_index :items_shoppinglists, ["item_id", "shoppinglist_id"]
  end

  def down
  	drop_table :items_shoppinglists
  end

end
