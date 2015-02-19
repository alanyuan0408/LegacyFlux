class FeedbanksController < ApplicationController

	def index
		@feedbanks = Feedbank.all
	end

	def create
  	@Feedbank = Feedbank.new(params[:feedbank])

  	if @Feedbank.save
     
      @Feedbank.update_attribute(:user_id, current_user.id)

      if current_user.account_setting.admin or current_user.account_setting.news_admin
        @Feedbank.update_column(:approval_status, true)
      else
        @Feedbank.update_column(:approval_status, false)
      end

    end

    #Debug/ Display the Errors
    @Feedbank.errors.full_messages.each do |msg|
      puts msg
    end

    respond_to do |format|
      format.js
    end

  end

  def add_post

    @feedbank_posts = Feedbank.where(user_id: current_user.id).order("item_date desc")

  end


  def show
    #@feedbanks = Feedbank.all
    @feedbank = Feedbank.find_by_id(params[:id])
  end 

  def approve_content
    @feedbank  = Feedbank.find(params[:id])
    @feedbank.update_attribute(:approval_status, 'true');

    respond_to do |format|
      format.js
    end

  end 

  def disapprove_content
    @feedbank  = Feedbank.find(params[:id])
    @feedbank.destroy

    respond_to do |format|
      format.js
    end

  end 


end
