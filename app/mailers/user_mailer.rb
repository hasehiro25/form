# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(@user.activation_token)
    mail(to: user.email, subject: "Formへのご登録ありがとうございます")
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    mail(to: user.email, subject: "Formのアカウントを有効にしました")
  end
end