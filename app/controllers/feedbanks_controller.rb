class FeedbanksController < ApplicationController

	def index
		@feedbanks = Feedbank.all
	end

	def create
  	@Feedbank = Feedbank.new(params[:feedbank])
    @Feedbank.update_attribute(:item_id, SecureRandom.urlsafe_base64)

  	@Feedbank.save

	  redirect_to :back
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
