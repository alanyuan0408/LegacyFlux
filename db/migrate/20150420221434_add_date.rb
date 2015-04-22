class AddDate < ActiveRecord::Migration
  def change

  	add_column :feedbanks, :event_date, :datetime
  end
end
