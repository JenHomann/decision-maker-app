ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "decision-maker-app.herokuapp.com",
  :user_name            => ENV['USERNAME'],
  :password             => ENV['EMAIL_PW'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "decision-maker-app.herokuapp.com"