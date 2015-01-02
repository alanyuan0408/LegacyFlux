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
  alias :devise_valid_password? :valid_password?

  def valid_password?(password)
    begin
      super(password)
    rescue BCrypt::Errors::InvalidHash
      return false unless BCrypt::Password.new(password) == encrypted_password
      logger.info "User #{email} is using the old password hashing method, updating attribute."
      self.password = password
      true
    end
  end
end
