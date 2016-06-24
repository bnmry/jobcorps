class UserNotifier < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Activate your account'
    @body[:url]  = "http://jobcorps.ausg.org/account/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Account activated'
    @body[:url]  = "http://jobcorps.ausg.org/"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Change your password'
    @body[:url]  = "http://jobcorps.ausg.org/account/reset_password/#{user.password_reset_code}" 
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Password reset'
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}" 
      @from        = "do-not-reply@jobcorps.ausg.org" 
      @subject     = "[JobCorps]" 
      @sent_on     = Time.now
      @body[:user] = user
    end
end
