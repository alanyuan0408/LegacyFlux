desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."	
end

task :send_emails => :environment do
  puts "sending emails"

  @user = User.where(:email_confirmation_token, "confirmed")

  @user.each do |user|
  	 UserMailer.update_email(user).deliver
  end

end

task :send_reminder => :environment do
  puts "send reminders to users"

  @user = User.all

  @user.each do |user|
    UserMailer.remind_email(user).deliver
  end


end