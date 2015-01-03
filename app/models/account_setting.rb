class AccountSetting < ActiveRecord::Base

	attr_protected :approval_message, :account_selected, :content_creator, :student_account, :content_approved, :sent_approval

	belongs_to :user
end
