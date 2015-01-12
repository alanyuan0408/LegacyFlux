class NewsEntry < ActiveRecord::Migration
  def change
  	add_column :news_letter_entries, :item_id, :string
  end
end
