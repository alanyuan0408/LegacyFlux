class FeedbankEntries < ActiveRecord::Migration
  def change
  	add_column :feedbanks, :disapproval_reason, :text
	add_column :news_letter_entries, :entry_text_md, :text
	add_column :news_letter_mails, :intro_message_md, :text

	add_column :feedbanks, :important, :boolean, :default => false
	add_column :feedbanks, :cs_grad, :boolean, :default => false
	add_column :feedbanks, :cs_undergrad, :boolean, :default => false
  end
end
