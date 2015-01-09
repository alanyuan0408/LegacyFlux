class FeedbanksController < ApplicationController

	def index
		@feedbanks = Feedbank.all
	end

	def create
  	@Feedbank = Feedbank.new(params[:feedbank])

  	@Feedbank.save
    @current_user = current_user
  	redirect_to @current_user
  end

  def show
    @feedbanks = Feedbank.all
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
    @feedbank.update_attribute(:approval_status, 'false');

    respond_to do |format|
      format.js
    end

  end 

end
