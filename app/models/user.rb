class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :mail_setting, dependent: :destroy
  has_one :account_setting, dependent: :destroy

  attr_accessible :email, :password, :password_confirmation, :name

  before_save :create_dependencies

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
 
end
