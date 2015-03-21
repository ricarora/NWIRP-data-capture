class AdminMailer < ActionMailer::Base
  default from: "database@nwirp.org"

  def new_user_waiting_for_approval(user)
    @user = user
    mail(to: "katesuzannefulton@gmail.com",
    subject: "Registration Request for <#{user.email}>")
  end

end
