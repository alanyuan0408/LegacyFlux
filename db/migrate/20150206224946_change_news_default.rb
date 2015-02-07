class ChangeNewsDefault < ActiveRecord::Migration
  def change
      change_column :mail_settings, :news, :boolean, :default => false
	  change_column :mail_settings, :events, :boolean, :default => false
  end
end
