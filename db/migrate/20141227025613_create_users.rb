class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
  	  t.boolean :users, :confirmationMail, :default => false
      t.string :users, :email_confirmation_token

      t.timestamps null: false
    end
  end

end
