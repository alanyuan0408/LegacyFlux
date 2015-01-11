class Feedbank < ActiveRecord::Base

  attr_accessible :item_date, :item_url, :item_title, :item_text, :user_id, :approval_status, :column_type

  validates :item_title, presence: true
  validates :item_text, presence: true

  before_save do |feedbank|
      feedbank.item_url = "http://#{item_url}" unless feedbank.item_url=~/^https?:\/\//
  end 
end
