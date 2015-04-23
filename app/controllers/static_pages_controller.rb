class StaticPagesController < ApplicationController

  def home
    
  end

  def developer

  end

  def expo
	
  end
  
  def news
    @news = Feedbank.where(:column_type => [2,3]).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def jobs
    @jobs = Feedbank.where(:column_type => [1,4]).where(:approval_status => true).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def mailing

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

