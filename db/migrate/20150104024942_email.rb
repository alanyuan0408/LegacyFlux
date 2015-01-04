class Email < ActiveRecord::Migration
  def change
  	add_column :users, :confirmationMail, :boolean, :default => false
    add_column :users, :email_confirmation_token, :string
  end
end
