class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      	t.string :name
	  	t.string :email
    	t.string :password_digest
    	t.string :password_confirmation
    	t.string :remember_token
    	t.boolean :admin
    	t.integer :email_frequency, :default => 7
    	t.boolean :news, :default => true
    	t.boolean :research, :default => true
    	t.boolean :jobs, :default => true
    	t.boolean :events, :default => true
    	t.boolean :expo_ticket, :default => false
    	t.datetime :nextsend
    	t.string :organization
    	t.string :approval_message
    	t.boolean :confirmationMail, :default => false
    	t.string :email_confirmation_token
   		t.boolean :account_created, :default => false
    	t.boolean :account_selected, :default => false
    	t.boolean :content_creator, :default => false
    	t.boolean :student_account, :default => false
    	t.boolean :content_approved, :default => false
    	t.boolean :sent_approval, :default => false

      t.timestamps null: false
    end
  end

end
