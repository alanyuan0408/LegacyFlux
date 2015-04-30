class FeedbanksController < ApplicationController

	def index
		@feedbanks = Feedbank.all
	end

  def search_feedbank

    respond_to do |format|
      format.html {

        puts params[:search_params]

        if params[:search_params].blank?
          
            render :nothing => true, :status => 200, :content_type => 'text/html'

        else

          search_condition = "%" + params[:search_params] + "%"
          @feedbank = Feedbank.where('item_title LIKE :title1 OR item_text LIKE :title2', 
            {:title1 => search_condition, :title2 => search_condition}).limit(7).order('created_at DESC')

          render :partial => "feedbanks/feedbankpartial/searchresultpartial"
        end 

      }
    end

  end

	def create
  	@Feedbank = Feedbank.new(params[:feedbank])

  	if @Feedbank.save
     
      @Feedbank.update_attribute(:user_id, current_user.id)

      if current_user.account_setting.admin or current_user.account_setting.news_admin
        @Feedbank.update_column(:approval_status, true)
      else
        @Feedbank.update_column(:approval_status, nil)
      end

    end

    @feedbank_posts = Feedbank.where(user_id: current_user.id).order("item_date desc")

    #Debug/ Display the Errors
    @Feedbank.errors.full_messages.each do |msg|
      puts msg
    end

    respond_to do |format|
      format.js
    end

  end

  def show
    #@feedbanks = Feedbank.all
    @feedbank = Feedbank.find_by_id(params[:id])
  end 

  def approve_content
    @feedbank  = Feedbank.find(params[:id])
    @feedbank.update_column(:approval_status, true);

    respond_to do |format|
      format.js
    end

  end 

  def disapprove_content
    @feedbank  = Feedbank.find(params[:id])
    @feedbank.update_column(:approval_status, false);

    respond_to do |format|
      format.js
    end

  end 


end
