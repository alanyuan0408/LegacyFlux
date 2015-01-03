class MailSetting < ActiveRecord::Base

	attr_protected :email_frequency, :news, :research, :jobs, :events, :expo_ticket, :nextsend

	validates :email_frequency, presence: true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 7 }

	belongs_to :user
end
