class AddTibbits < ActiveRecord::Migration
  def change
  	add_column :news_letter_entries, :tibbit_entry, :boolean, :default => false
  end
end
