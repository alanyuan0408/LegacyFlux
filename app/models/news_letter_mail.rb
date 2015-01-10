class NewsLetterMail < ActiveRecord::Base

	belongs_to :user

	has_many :news_letter_entry
end
