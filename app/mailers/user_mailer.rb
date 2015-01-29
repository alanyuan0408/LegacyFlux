class UserMailer < ActionMailer::Base

  default from: "alan.yuan@mail.utoronto.ca"

  def welcome_email(user)

    @user = user
    mail(to: @user.email, subject: 'SignUp Email') do |format|
      format.text { render 'user_mailer/welcome_email_text'.encode("UTF-8") }
      format.html { render 'user_mailer/welcome_email' }
    end

  end

  def remind_email(user)

    @user = user
    @mail_setting = @user.mail_setting

    if (@mail_setting.jobs && @mail_setting.news && @mail_setting.events && @mail_setting.research && @mail_setting.email_frequency == 7)

        mail(to: @user.email, subject: 'WebDev Modify Settings') do |format|
          format.html { render 'user_mailer/remind_email_text' }
          format.text { render 'user_mailer/remind_email' }
        end
    end
    
  end

  def update_email(user)
    
    @user = user
    @mail_setting = @user.mail_setting
    @account_setting = @user.account_setting
    count = 0
    #If there are no updates, send nothing

    #If the Email is out of date + the user wants emails.
    if (!@mail_setting.nextsend or @mail_setting.nextsend < Time.now) && @account_setting.student_account

      if @mail_setting.news
        @news = Feedbank.where(:column_type => 3).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend - 
            @mail_setting.email_frequency.days}).order("created_at desc").limit(4)
          count += @news.length
      end

      if @mail_setting.jobs
        @jobs = Feedbank.where(:column_type => 1).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend  - @mail_setting.email_frequency.days
            }).order("created_at desc").limit(4)
          count += @jobs.length
      end

      if @mail_setting.research
        @research = Feedbank.where(:column_type => 4).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend - @mail_setting.email_frequency.days
            }).order("created_at desc").limit(4)
          count += @research.length
      end

      if @mail_setting.events
        @events = Feedbank.where(:column_type => 2).where(:approval_status => true).
          where("created_at >= :last_send",
          {last_send: @mail_setting.nextsend - @mail_setting.email_frequency.days
            }).order("created_at desc").limit(4)
          count += @events.length
      end

      newtime = Time.now + @mail_setting.email_frequency.days
      @mail_setting.update_attribute(:nextsend, newtime)

      if (count > 0)

        mail(to: @user.email, subject: 'Automated Web Club Email') do |format|
          format.text { render 'user_mailer/update_email_text' }
          format.html { render 'user_mailer/update_email' }
        end

      end

    end

  end


end
