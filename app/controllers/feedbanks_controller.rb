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
    @feedbank.update_attribute(:approval_status, "true");


    @admin_user = User.find_by_name("Admin");
    redirect_to @admin_user 
  end 

  def disapprove_content
    @feedbank  = Feedbank.find(params[:id])
    @feedbank.destroy


    @admin_user = User.find_by_name("Admin");
    redirect_to @admin_user 
  end 

end
