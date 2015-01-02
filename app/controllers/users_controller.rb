class UsersController < ApplicationController

  def show

    if user_signed_in?
      @user = User.find(params[:id])
      @user_name = @user.name
      @feedbank_posts = Feedbank.where(user_id: @user.id)

      if @user.admin && current_user.remember_token == @user.remember_token
        @post_request = User.where(sent_approval: true).where(content_approved: false).all
        @users = User.where(student_account: true).order("created_at desc")
        @creators = User.where(content_creator: true).order("created_at desc")
        @confirmed_users = User.where(email_confirmation_token: "confirmed").length

        @user_posts = Feedbank.where(approval_status: false).all
        render 'admin_page'

      elsif (!@user.account_selected) && current_user.remember_token == @user.remember_token
        render 'account_select'

      elsif !@user.student_account && @user.content_creator && (!@user.sent_approval) && current_user.remember_token == @user.remember_token
        render 'approve_creator'

      elsif !@user.student_account &&  @user.content_creator && @user.sent_approval && current_user.remember_token == @user.remember_token
        render 'content_page'

      elsif @user.student_account && current_user.remember_token == @user.remember_token
          #render the student page
      else
        @user = User.find(params[:id])
        @user_name = "Account Login"
        render 'permissiondenied'
      end
    else
      @user_name = "Account Login"
      render 'permissiondenied'
    end
  end

  def index

  end

  def edit

  end

  def update

    if @user.update_attributes(params[:user])
        if @user.content_creator
          @user.update_attribute(:sent_approval, true);
        end
        sign_in @user
        redirect_to @user
    else
      @currentPage[:usererror] = "true"
      render 'edit'
    end
  end

  def register_expo
    @current_user = current_user;
    @user = @current_user.account_setting.find(1);
    @user.update_attribute(:expo_ticket, true);
    @registration = "true";

    @number_of_participants = User.where(:expo_ticket => true).length;
    render 'static_pages/entrepreneur'
  end 

  def unregister_expo
    @current_user = current_user;
    @user = @current_user.account_setting.find(1);
    @user.update_attribute(:expo_ticket, false);
    @registration = "false";

    @number_of_participants = User.where(:expo_ticket => true).length;
    render 'static_pages/entrepreneur'
  end 

  def student_account
    @user = User.find_by_id(session[:remember_token])
    @user.update_attribute(:student_account, true);
    @user.update_attribute(:account_selected, true);
    @currentPage = {:useraccount => "active"};
    @user_name = @user.name
    redirect_to @user
  end

  def creator_account
    @user = User.find_by_id(session[:remember_token])
    @user.update_attribute(:content_creator, true);
    @user.update_attribute(:account_selected, true);
    @currentPage = {:useraccount => "active"};
    @user_name = @user.name
    redirect_to @user
  end

  def confirmation_token
    @user = User.find_by_email_confirmation_token(params[:email_confirmation_token]);

    if @user.blank?
      render 'permissiondenied'
    else 
      sign_in @user
      @currentPage = {:useraccount => "active"};
      @user_name = @user.name
      @user.update_column(:email_confirmation_token, "confirmed")
      render 'users/confirmMail'
    end 
  end

  def request_creator
    @user = User.find_by_id(session[:remember_token])
    @user.update_attribute(:sent_approval, true);
    @user.update_attribute(:content_creator, true);
    @user.update_attribute(:organization, params[:organization]);
    @user.update_attribute(:approval_message, params[:approval_message]);

    @currentPage = {:useraccount => "active"};
    @user_name = @user.name
    redirect_to @user
  end

  def approve_creator 
    @user = User.find(params[:id])
    @user.update_attribute(:content_approved, true);

    @admin_user = User.find_by_name("Admin");
    redirect_to @admin_user 
  end

  def change_password
    @user = User.find([params[:id]])
    
  end

end
