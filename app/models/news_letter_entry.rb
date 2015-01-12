class NewsLetterEntry < ActiveRecord::Base

	belongs_to :news_letter_mail

	attr_protected :entry_title, :entry_text

end
