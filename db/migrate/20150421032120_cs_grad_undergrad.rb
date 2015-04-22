class CsGradUndergrad < ActiveRecord::Migration
  def change
  	add_column :mail_settings, :cs_undergrad, :boolean, :default => false
	add_column :mail_settings, :cs_grad, :boolean, :default => false 
  end
end
