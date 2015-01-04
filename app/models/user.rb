class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :mail_setting, dependent: :destroy
  accepts_nested_attributes_for :mail_setting
  has_one :account_setting, dependent: :destroy
  accepts_nested_attributes_for :account_setting

  attr_accessible :email, :password, :password_confirmation, :name

  before_save :create_dependencies, on: :create
  after_commit :send_confirmation_email

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

  private

  def create_dependencies
    #Setup the Mail_setting and account_setting dependencies
      @account_setting = AccountSetting.new
      @account_setting.approval_message = ""
      @account_setting.user_id = self.id
      @account_setting.save

      @mail_setting = MailSetting.new
      @mail_setting.nextsend = Time.now + 7.days
      @mail_setting.user_id = self.id
      @mail_setting.save
  end

  def send_confirmation_email
    if self.confirmationMail == "true"
      #Nothing/ Prevent Double Send
    else
      self.confirmationMail = "true"
      # send user email of confirmation if they haven't confirmed their email yet
      self.update_column(:email_confirmation_token, SecureRandom.urlsafe_base64)
         
      UserMailer.welcome_email(self).deliver
    end
  end
 
end
