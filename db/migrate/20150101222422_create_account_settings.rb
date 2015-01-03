class CreateAccountSettings < ActiveRecord::Migration
  def change

    create_table :account_settings do |t|

    	t.belongs_to :user, index: true
    	t.string :approval_message
    	t.boolean :account_selected, :default => false
    	t.boolean :content_creator, :default => false
    	t.boolean :student_account, :default => false
    	t.boolean :content_approved, :default => false
    	t.boolean :sent_approval, :default => false

      t.timestamps null: false
    end
  end
end
