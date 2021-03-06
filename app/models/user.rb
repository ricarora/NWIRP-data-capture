# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_admin_mail

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def self.find_all_by_approved(value)
    User.all.where(approved: :false)
  end

  def approve_user(current_user)
    if current_user && current_user.admin
      self.approved = true
    end
  end

  def approve_admin(current_user)
    if current_user && current_user.admin
      self.admin = true
    end
  end

  def remove_admin(current_user)
    if current_user && current_user.admin
      self.admin = false
    end
  end
end
