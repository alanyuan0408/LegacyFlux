class CreateFeedbanks < ActiveRecord::Migration
  def change
    create_table :feedbanks do |t|

    	t.string :item_id
    	t.string :item_url
    	t.string :item_title
    	t.datetime :item_date
    	t.text :item_text
    	t.integer :column_type
    	t.integer :user_id
    	t.boolean :approval_status, :default => false

      t.timestamps null: false
    end
  end
end


