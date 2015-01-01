class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_protected :email_frequency, :news, :research, :jobs, :events, :expo_ticket, :approval_message, :organization
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_one :mail_setting
  has_one :account_setting

  validates :name,  presence: true
  validates :email_frequency, presence: true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 7 }

  private 

end
