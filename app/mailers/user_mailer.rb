class UserMailer < ActionMailer::Base
  require 'mail'
  default from: "alan.yuan@mail.utoronto.ca"

  def welcome_email(user)

      @user = user
      mail(to: @user.email, subject: 'SignUp Email')

  end

  def update_email(user)
    
    @user = user
    @mail_setting = @user.mail_setting

    if @mail_setting.nextsend < Time.now or !@mail_setting.nextsend
      newtime = Time.now + @mail_setting.email_frequency.days
      

      @feedbanks = Feedbank.where("created_at >= :last_send",
        {last_send: @mail_setting.nextsend}).limit(5)

      @mail_setting.update_attribute(:nextsend, newtime)
      mail(to: @user.email, subject: 'Automated Web Club Email')
    end

  end


end
