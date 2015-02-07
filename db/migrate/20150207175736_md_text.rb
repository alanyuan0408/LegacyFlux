class MdText < ActiveRecord::Migration
  def change
  	  add_column :news_letter_entries, :entry_text_md, :string
	  add_column :news_letter_mails, :intro_message_md, :string
  end
end
