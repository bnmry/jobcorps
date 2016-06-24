# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  layout "standard"
  include AuthenticatedSystem
  before_filter :login_from_cookie
  
    before_filter do |c|
      if !c.session[:user].nil?
        User.current_user = c.session[:user]
      end
    end
      
  def authenticated?
    if logged_in?
      true
    else
      false
    end
  end
  helper_method :authenticated?
  
  def is_administrator?
    if logged_in?
    if
      current_user.identity == 1
      true
    else
      false
    end
  end
  end
  helper_method :is_administrator?
    
  def is_student?
    if logged_in?
      if 
        current_user.identity == 2  
        true
      elsif
        current_user.identity == 1
        true
      else
        false
      end
    end
  end
  helper_method :is_student?
  
  def is_employer?
    if logged_in?
    if 
      current_user.identity == 3
      true
    elsif
      current_user.identity == 1
      true
    else
      false
    end
  end
  end
  helper_method :is_employer?
  
  def can_edit_job?
    @job = Job.find(params[:id])
    if logged_in?
      if
        @job.user.id == current_user.id
        true
      elsif
        is_administrator?
        true
      else
        false
      end
    end
  end
  helper_method :can_edit_job?
  
  def can_edit_student?
    @student = Student.find(params[:id])
    if logged_in?
    if
      @student.user.id == current_user.id
      true
    elsif
      is_administrator?
      true
    else
      false
    end
  end
  end
  helper_method :can_edit_student?
  
  def rescue_action_in_public(exception)
    case exception
    when ActiveRecord::RecordNotFound, ActionController::UnknownAction
      render(:file => "#{RAILS_ROOT}/public/404.html", :status => "404 Not Found")
    else
      render(:file => "#{RAILS_ROOT}/public/500.html", :status => "500 Error")
      SystemNotifier.deliver_exception_notification(
      self, request, exception)
    end
  end
end