class StaticPagesController < ApplicationController

  def home
    
  end

  def developer

  end

  def expo

    if user_signed_in?
      @current_user = current_user;
      @account_setting = @current_user.mail_setting.expo_ticket;
    else 
      @expo_ticket = "false"
    end

    @number_of_participants = MailSetting.where(:expo_ticket => true).length;
  end
  
  def research
    @research = Feedbank.where(:column_type => 4).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end
  
  def news
    @news = Feedbank.where(:column_type => 3).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def events
    @events = Feedbank.where(:column_type => 2).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research

  end

  def jobs
    @jobs = Feedbank.where(:column_type => 1).order("item_date desc").page(params[:page]).per(10)
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

