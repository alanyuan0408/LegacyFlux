class MailSetting < ActiveRecord::Base

	attr_protected :nextsend

	belongs_to :user
end
