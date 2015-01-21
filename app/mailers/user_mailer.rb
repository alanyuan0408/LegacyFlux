class UserMailer < ActionMailer::Base

  default from: "alan.yuan@mail.utoronto.ca"

  def welcome_email(user)

    @user = user
    mail(to: @user.email, subject: 'SignUp Email') do |format|
      format.text { render :partial => "user_mailer/welcome_email_text" }
      format.html { render :partial => "user_mailer/welcome_email" }
    end

  end

  def update_email(user)
    
    @user = user
    @mail_setting = @user.mail_setting
    @account_setting = @user.account_setting

    #If the Email is out of date + the user wants emails.
    if (@mail_setting.nextsend < Time.now or !@mail_setting.nextsend) && @account_setting.student_account

      if @mail_setting.news
        @news = Feedbank.where(:column_type => 3).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend}).limit(3)
      end

      if @mail_setting.jobs
        @jobs = Feedbank.where(:column_type => 1).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend}).limit(3)
      end

      if @mail_setting.research
        @research = Feedbank.where(:column_type => 4).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend}).limit(3)
      end

      if @mail_setting.events
        @events = Feedbank.where(:column_type => 2).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend}).limit(3)
      end

      newtime = Time.now + @mail_setting.email_frequency.days
      @mail_setting.update_attribute(:nextsend, newtime)

      mail(to: @user.email, subject: 'Automated Web Club Email') do |format|
        format.text { render :partial => "user_mailer/update_email_text" }
        format.html { render :partial => "user_mailer/update_email" }
      end

    end

  end


end
