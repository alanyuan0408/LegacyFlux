class NewsLetterMail < ActiveRecord::Base

	belongs_to :user

	attr_protected :user_id

	has_many :news_letter_entries
	accepts_nested_attributes_for :news_letter_entries

end
