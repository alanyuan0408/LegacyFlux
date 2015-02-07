class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_one :mail_setting, dependent: :destroy
  accepts_nested_attributes_for :mail_setting
  has_one :account_setting, dependent: :destroy
  accepts_nested_attributes_for :account_setting
  has_one :news_letter_mail, dependent: :destroy
  accepts_nested_attributes_for :news_letter_mail

  attr_accessible :email, :password, :password_confirmation, :name

  after_commit :send_confirmation_email, on: :create

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

  def self.from_omniauth(auth)
  if self.where(email: auth.info.email).exists?
    user = self.where(email: auth.info.email).first
    user.provider = auth.provider
    user.uid = auth.uid
	return model
  else
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.name = auth.info.name
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.oauth_token = auth.credentials.token
       user.oauth_expires_at = Time.at(auth.credentials.expires_at) 
	end
	return model
  end
end

 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  private

  def send_confirmation_email
    if self.confirmationMail == "true"
      #Nothing/ Prevent Double Send
    else
      self.update_column(:email_confirmation_token, SecureRandom.urlsafe_base64)
      self.update_column(:confirmationMail, "true")

      #Create the Dependencies
      self.account_setting = AccountSetting.new
      self.account_setting.update_column(:user_id, self.id)
      self.account_setting.save

      self.mail_setting = MailSetting.new
      self.mail_setting.update_column(:nextsend, Time.now + 7.days)
      self.mail_setting.update_column(:user_id, self.id)
      self.mail_setting.update_column(:news, true)
      self.mail_setting.update_column(:events, true)
      self.mail_setting.save

      #IMPORTANT! ONLY USED DURING TESTING STAGE// SEED IT FOR THE RELEASE
      self.news_letter_mail = NewsLetterMail.new
      self.news_letter_mail.save

      # send user email of confirmation if they haven't confirmed their email yet
      UserMailer.welcome_email(self).deliver_now
      
    end
  end
 
end
