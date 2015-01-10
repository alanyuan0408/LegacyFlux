class UsersController < ApplicationController

  before_action :find_user

  def show

    if user_signed_in?

      @feedbank_posts = Feedbank.where(user_id: @current_user.id).order("item_date desc")
      @unconfirmed_posts = Feedbank.where(approval_status: false).order("item_date desc")

      @mail_posts = Feedbank.where('created_at >= ?', 3.weeks.ago).order("item_date desc")

      @mail_setting = @current_user.mail_setting
      @account_setting = @current_user.account_setting

      #Render the User Page

    else
      render 'permissiondenied'
    end

  end

  def index

  end

  def save_setting

    respond_to do |format|
      format.js
    end

  end

  def modify

    param = params[:user][:mail_setting_attributes]

    #Update User Settings [No Mass- Assignment]
    @current_user.mail_setting.update_attribute(:news, 
      param[:news])
    @current_user.mail_setting.update_attribute(:research, 
      param[:research])
    @current_user.mail_setting.update_attribute(:jobs, 
      param[:jobs])
    @current_user.mail_setting.update_attribute(:events, 
      param[:events])

    if (param[:email_frequency].to_i < 1)
      email_frequency = 1
    elsif (param[:email_frequency].to_i > 7)
      email_frequency = 7
    else
      email_frequency = param[:email_frequency].to_i
    end

    @current_user.mail_setting.update_attribute(:email_frequency, 
        email_frequency)

    @current_user.mail_setting.update_attribute(:nextsend, Time.now + email_frequency.days)

    @mail_setting = @current_user.mail_setting

    respond_to do |format|
      format.js
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
    @current_user.account_setting.update_attribute(:approval_message, 
                params[:approval_message]);

    redirect_to @current_user
  end

  def approve_creator 
    @user = User.find(params[:id])
    @user.account_setting.update_attribute(:content_approved, true);

    redirect_to @current_user
  end


   def confirmation_token
    @user = User.find_by_email_confirmation_token(params[:email_confirmation_token]);

    if @user.blank?
      render 'permissiondenied'
    else 

      @user.update_column(:email_confirmation_token, nil)
      render 'users/confirmMail'
    end 
  end

  private 

    def find_user
      @current_user = current_user
    end

end
