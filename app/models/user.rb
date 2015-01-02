class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :mail_setting
  has_one :account_setting

  attr_accessible :email, :password, :password_confirmation, :name

  validates :name,  presence: true

end
