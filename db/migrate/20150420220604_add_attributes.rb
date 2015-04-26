class AddAttributes < ActiveRecord::Migration
  def change
  	add_column :feedbanks, :content_modification, :boolean, :default => false

  	add_column :mail_settings, :full_time_job, :boolean, :default => true
	add_column :mail_settings, :Internship_job, :boolean, :default => true
	add_column :mail_settings, :Research_job, :boolean, :default => true
	add_column :mail_settings, :Part_time_job, :boolean, :default => true 
	remove_column :mail_settings, :jobs
	remove_column :mail_settings, :research
	remove_column :mail_settings, :expo_ticket
  end
end
