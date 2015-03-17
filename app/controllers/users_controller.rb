class UsersController < ApplicationController

  before_action :authenticate_user!

  def adminPanel
      @mail_setting = current_user.mail_setting
      @account_setting = current_user.account_setting
      @unconfirmed_posts = Feedbank.where(approval_status: nil).order("item_date desc")
  end

  def mailPanel
      do_not_cache

      @mail_setting = current_user.mail_setting
      @account_setting = current_user.account_setting
      
      @mail_posts = Feedbank.where('created_at >= ?', 3.weeks.ago).where('column_type <> ?', 5).order("item_date desc")
  end

  def index

  end

  def add_post
    @feedbank_posts = Feedbank.where(user_id: current_user.id).order("item_date desc")
  end

  def usersetting
      @mail_setting = current_user.mail_setting
      @account_setting = current_user.account_setting
  end
  
  def send_mail
    @mail_users = User.all

    @mail_users.each do |user|
      UserMailer.update_email(user).deliver_now
    end

  end

  def modify

    param = params[:user][:mail_setting_attributes]

    #Update User Settings [No Mass- Assignment]
    current_user.mail_setting.update_attribute(:news, 
      param[:news])
    current_user.mail_setting.update_attribute(:research, 
      param[:research])
    current_user.mail_setting.update_attribute(:jobs, 
      param[:jobs])
    current_user.mail_setting.update_attribute(:events, 
      param[:events])

    if (param[:email_frequency].to_i < 1)
      email_frequency = 1
    elsif (param[:email_frequency].to_i > 7)
      email_frequency = 7
    else
      email_frequency = param[:email_frequency].to_i
    end

    current_user.mail_setting.update_attribute(:email_frequency, 
        email_frequency)
    current_user.mail_setting.update_attribute(:nextsend, Time.now + email_frequency.days)
    @mail_setting = current_user.mail_setting

    respond_to do |format|
      format.js
    end

  end

  def student_account
    current_user.account_setting.update_attribute(:student_account, true);
    current_user.mail_setting.update_attribute(:nextsend, Time.now + 1.days);
    redirect_to(:back)
  end

  def disable_student_account
    current_user.account_setting.update_attribute(:student_account, false);
    current_user.mail_setting.update_attribute(:nextsend, Time.now + 7.days);
    redirect_to(:back)
  end

  def generate_newsLetter
  
    generate_header

    current_user.save

    id_list = params[:user][:ordering].split(" ")
    puts id_list
    iterator = 0
    
    id_list.each do |id_entry|
      puts id_entry
      @var = current_user.news_letter_mail.news_letter_entries.find_by(item_id: id_entry)

      @var.update_attribute(:ordering, iterator)
      iterator += 1
      @var.save
    end
  if params[:commit] == 'View .HTML'
    render :layout => false
  elsif params[:commit] == 'Generate .MD'
   render file: "users/generate_newsLetter_md.html.erb", content_type: "text/x-markdown", :layout => false
   else
    render :layout => false
   end
	
  end
  
  def generate_newsLetter_md

    generate_header

    current_user.save

    id_list = params[:user][:ordering].split(" ")
    puts id_list
    iterator = 0
    
    id_list.each do |id_entry|
      puts id_entry
      @var = current_user.news_letter_mail.news_letter_entries.find_by(item_id: id_entry)

      @var.update_attribute(:ordering, iterator)
      iterator += 1
      @var.save
    end

    render :layout => false

  end

  def mail_delete_dependencies

    @newsItems = current_user.news_letter_mail.news_letter_entries.all

    @newsItems.each do |entry|
      entry.destroy
    end

    @mail_posts = Feedbank.where('created_at >= ?', 3.weeks.ago).order("item_date desc")

    respond_to do |format|
      format.js
    end

  end

  def add_tidbit


    #Prevent Mutiple Requests for slow connections
    if current_user.news_letter_mail.news_letter_entries.find_by(item_id: params[:item_id])
      #DO nothing, request already sent

    else 

      param = params[:user][:news_letter_mail_attributes][:news_letter_entry]

      @newPost = current_user.news_letter_mail.news_letter_entries.new

      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

      @newPost.update_attribute(:entry_title, param[:entry_title])
      @newPost.update_attribute(:entry_text, markdown.render(param[:entry_text]))
      @newPost.update_attribute(:entry_text_md, param[:entry_text])
      @newPost.update_attribute(:item_id, SecureRandom.urlsafe_base64)
      @newPost.update_attribute(:tibbit_entry, true)
      @newPost.save
    end

    respond_to do |format|
      format.js
    end

  end

  def add_newsItem
    @feedbank = Feedbank.find(params[:id])

    #Prevent Mutiple Requests for slow connections
    if current_user.news_letter_mail.news_letter_entries.find_by(item_id: params[:item_id])
      #DO nothing, request already sent

    else 
      @newPost = current_user.news_letter_mail.news_letter_entries.new
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

      @newPost.update_attribute(:entry_title, params[:user][:entry_title])
      @newPost.update_attribute(:entry_text, markdown.render(params[:user][:entry_text]))
      @newPost.update_attribute(:entry_text_md, params[:user][:entry_text])
      @newPost.update_attribute(:item_id, @feedbank.item_id)
      @newPost.save
    end

    @mail_posts = Feedbank.where('created_at >= ?', 3.weeks.ago).where('column_type <> ?', 5).order("item_date desc")

    respond_to do |format|
      format.js
    end

  end

  def remove_newsItem
    @newPost = current_user.news_letter_mail.news_letter_entries.
                        find_by(item_id: params[:item_id])
    @newPost.destroy

    @mail_posts = Feedbank.where('created_at >= ?', 3.weeks.ago).order("item_date desc")

    respond_to do |format|
      format.js
    end

  end

   def confirmation_token
    @user = User.find_by_email_confirmation_token(params[:email_confirmation_token]);

    if @user.blank?
      render 'permissiondenied'
    else 
      @user.update_column(:email_confirmation_token, "confirmed")
      sign_in @user
      render 'users/confirmMail'
    end 
  end

  private 

    def news_entry_params
      params.required(:person).permit(:name, :age)
    end

    def generate_header 
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
      
      current_user.news_letter_mail.update_attribute(:intro_message, 
        markdown.render(params[:user][:entry_text]))
      current_user.news_letter_mail.update_attribute(:intro_message_md, 
        params[:user][:entry_text])
    end

    def do_not_cache
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

end
