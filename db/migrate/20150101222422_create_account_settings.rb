class CreateAccountSettings < ActiveRecord::Migration
  def change

    create_table :account_settings do |t|

    	t.belongs_to :user, index: true

    	t.boolean :student_account, :default => false
      t.boolean :admin, :default => false 
      t.boolean :news_admin, :default => false 

      t.timestamps null: false
    end
  end
end
