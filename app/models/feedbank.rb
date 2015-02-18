class Feedbank < ActiveRecord::Base

  attr_accessible :item_date, :item_url, :item_title, :item_text, :user_id, :approval_status, :column_type

  validates :item_title, presence: true, allow_blank: false
  validates :item_text, presence: true, allow_blank: false

  before_save do |feedbank|
    if feedbank.item_url.blank?
		  feedbank.item_url = ""
	   else
		  feedbank.item_url = "http://#{item_url}" unless feedbank.item_url=~/^https?:\/\//
	   end

    feedbank.item_date = Time.current
  end 

  after_save do |feedbank|
    
    user_setting = User.find_by_id(feedbank.user_id)

    if user_setting.account_setting.admin or user_setting.account_setting.news_admin
      feedbank.update_column(:approval_status, true)
    else
      feedbank.update_column(:approval_status, false)
    end
  end
end
