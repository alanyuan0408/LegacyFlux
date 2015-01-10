class CreateNewsLetterMails < ActiveRecord::Migration
  def change
    create_table :news_letter_mails do |t|

      t.belongs_to :user, index: true
      
      t.timestamps null: false
    end
  end
end
