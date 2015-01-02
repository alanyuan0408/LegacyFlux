class UsersController < ApplicationController

  before_action :find_user

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
    @current_user.mail_setting.update_attribute(:expo_ticket, true);
    @account_setting = "true";

    @number_of_participants = MailSetting.where(:expo_ticket => true).length;
    render 'static_pages/expo'
  end 

  def unregister_expo
    @current_user.mail_setting.update_attribute(:expo_ticket, false);
    @account_setting = "false";

    @number_of_participants = MailSetting.where(:expo_ticket => true).length;
    render 'static_pages/expo'
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
    
    
  end

  private 

    def find_user
      @current_user = current_user
    end

end
