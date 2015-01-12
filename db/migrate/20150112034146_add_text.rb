class AddText < ActiveRecord::Migration
  def change

  	add_column :news_letter_entries, :ordering, :integer
  	add_column :news_letter_mails, :intro_message, :text
  end
end
