class Feedbank < ActiveRecord::Base

  attr_accessible :item_date, :item_url, :item_title, :item_text, :user_id, :approval_status, :column_type

  before_save :generate_id_string

  validates :item_title, presence: true
  validates :item_text, presence: true

  private 

  def generate_id_string

  	self.item_id = SecureRandom.urlsafe_base64

  end 

end
