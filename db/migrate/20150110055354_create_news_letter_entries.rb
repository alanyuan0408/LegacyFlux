class CreateNewsLetterEntries < ActiveRecord::Migration
  def change
    create_table :news_letter_entries do |t|

      t.belongs_to :news_letter_mail, index: true
      t.string :entry_title
      t.text :entry_text

      t.timestamps null: false
    end
  end
end
