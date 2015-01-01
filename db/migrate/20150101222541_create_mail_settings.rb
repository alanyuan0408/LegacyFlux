class CreateMailSettings < ActiveRecord::Migration
  def change
  	# Remove the columns from Users and added new Model

    create_table :mail_settings do |t|

      t.belongs_to :user, index: true
    	t.integer :email_frequency, :default => 7
    	t.boolean :news, :default => true
    	t.boolean :research, :default => true
    	t.boolean :jobs, :default => true
    	t.boolean :events, :default => true
    	t.boolean :expo_ticket, :default => false
    	t.datetime :nextsend

      t.timestamps null: false
    end
  end
end
