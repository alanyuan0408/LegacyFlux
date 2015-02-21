class Feedbank < ActiveRecord::Base

  attr_accessible :item_url, :item_title, :item_text, :column_type, :important, :cs_grad, :undergrad

  validates :item_title, presence: true, allow_blank: false
  validates :item_text, presence: true, allow_blank: false

  before_save do |feedbank|
    if feedbank.item_url.blank?
		  feedbank.item_url = ""
	   else
		  feedbank.item_url = "http://#{item_url}" unless feedbank.item_url=~/^https?:\/\//
	   end

    feedbank.item_date = Time.current
    feedbank.item_id = SecureRandom.urlsafe_base64

  end

end
