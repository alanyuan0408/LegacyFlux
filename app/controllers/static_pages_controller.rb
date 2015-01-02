class StaticPagesController < ApplicationController

  def home
    @currentUser = current_user
  end

  def developer
    login_method

    @currentPage = {:developer => "active"};
  end

  def entrepreneur
    login_method

    @currentPage = {:entrepreneur => "active"};
    @number_of_participants = User.where(:expo_ticket => true).length;
  end
  
  def research
    login_method

    @currentPage = {:news => "active"};
    @research = Feedbank.where(:column_type => 4).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research

  end
  
  def news
    login_method

    @currentPage = {:news => "active"};
    @news = Feedbank.where(:column_type => 3).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research

  end

  def events
    login_method

    @currentPage = {:events => "active"};
    @events = Feedbank.where(:column_type => 2).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research

  end

  def jobs
    login_method

    @currentPage = {:jobs => "active"};
    @jobs = Feedbank.where(:column_type => 1).order("item_date desc").page(params[:page]).per(10)
    #1 is Jobs, #2 is Events, #3 is News, #4 is Research
  end

  def useraccount
    current_user

    if signed_in?
      sign_in(@current_user)
    end

    @currentPage = {:useraccount => "active"};
    if session[:remember_token] && User.exists?(:id => session[:remember_token])
      @user = User.find(session[:remember_token])
      @user_name = @user.name
      redirect_to @user
    else
      @user_name = "Account Login"
      @user = User.new(params[:user])
      if @user.save
        #Handle a successful save.
        redirect_to @user
      else 
        render 'users/new'
      end
    end
  end
  
end

