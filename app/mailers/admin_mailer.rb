# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class AdminMailer < ActionMailer::Base
  default from: "database@nwirp.org"

  def new_user_waiting_for_approval(user)
    @user = user
    mail(to: "bill@nwirp.org",
    subject: "Registration Request for <#{user.email}>")
  end

end
