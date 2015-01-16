class StaticPagesController < ApplicationController

  def home
    
  end

  def developer

  end

  def expo

    if user_signed_in?
      @current_user = current_user;
      @account_setting = @current_user.mail_setting.expo_ticket;
      @expo_signup = Feedbank.where(:column_type => 5).where(:user_id => @current_user.id)
      #expo_signup is to check if the user already signup.
    else 
      @expo_ticket = "false"
    end

    @number_of_participants = MailSetting.where(:expo_ticket => true).length;
  end
  
  def research
    @research = Feedbank.where(:column_type => 4).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end
  
  def news
    @news = Feedbank.where(:column_type => 3).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def events
    @events = Feedbank.where(:column_type => 2).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def jobs
    @jobs = Feedbank.where(:column_type => 1).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def useraccount

    if user_signed_in?
      @user = current_user
      redirect_to @user
    else
      redirect_to '/user_info'
    end
  end
  
end

