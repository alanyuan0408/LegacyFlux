class MailSetting < ActiveRecord::Base

	attr_protected :email_frequency, :news, :research, :jobs, :events, :expo_ticket, :nextsend

	belongs_to :user
end
