class UsersController < ApplicationController

  before_action :find_user

  def show

    if user_signed_in?

      @feedbank_posts = Feedbank.where(user_id: @current_user.id)

      @email_setting = @current_user.email_setting
      @account_setting = @current_user.account_setting

      if @current_user.admin

        @user_posts = Feedbank.where(approval_status: false).all
        render 'admin_page'

      elsif @current_user.account_setting.student_account
        #render the student page [Default Page]

      elsif !@current_user.account_setting.account_selected
        render 'account_select'

      elsif (!@current_user.account_setting.sent_approval)
        render 'approve_creator'

      elsif @current_user.account_setting.sent_approval 
        render 'content_page'

      else
        render 'permissiondenied'
      end

    else
      render 'permissiondenied'
    end

  end

  def index

  end

  def edit

  end

  def update

    if @user.update_attributes(params[:user])
        redirect_to @current_user
    else
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
    @current_user.account_setting.update_attribute(:student_account, true);
    @current_user.account_setting.update_attribute(:account_selected, true);

    redirect_to @current_user
  end

  def creator_account
    @current_user.account_setting.update_attribute(:content_creator, true);
    @current_user.account_setting.update_attribute(:account_selected, true);

    redirect_to @current_user
  end

  def request_creator
    @current_user.account_setting.update_attribute(:sent_approval, true);
    @current_user.update_attribute(:organization, params[:organization]);
    @current_user.account_setting.update_attribute(:approval_message, params[:approval_message]);

    redirect_to @current_user
  end

  def approve_creator 
    @user = User.find(params[:id])
    @user.account_setting.update_attribute(:content_approved, true);

    redirect_to @current_user
  end

  def change_password
    
  end

  private 

    def find_user
      @current_user = current_user
    end

end
