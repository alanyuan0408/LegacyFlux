class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin, :default => false 
      t.boolean :news_admin, :default => false 
      t.string :organization, :default => ""

      t.timestamps null: false
    end
  end

end
