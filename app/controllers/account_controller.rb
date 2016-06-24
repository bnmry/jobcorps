class AccountController < ApplicationController

  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
    if is_administrator?
      redirect_to :action => "admin"
    elsif logged_in?
      @fullname = "#{current_user.firstname} #{current_user.lastname}"
      @notes_students = Note.find(:all, :conditions => ["user_id = ? and student_id > 0", current_user.id], :order => "created_on DESC")
      @notes_jobs = Note.find(:all, :conditions => ["user_id = ? and job_id > 0", current_user.id], :order => "created_on DESC")
      @students = Student.find(:all, :conditions => ["user_id =?", current_user.id],  :order => "created_at desc")
      @jobs = Job.find(:all, :conditions => ["user_id = ?", current_user.id], :order => "created_at desc")
      @favorites_students = Favorite.find(:all, :conditions => ["user_id = ? and job_id > 0", current_user.id], :order => "created_on DESC")
      @favorites_employers = Favorite.find(:all, :conditions => ["user_id = ? and student_id > 0", current_user.id], :order => "created_on DESC")
    else
      @fullname = "Not logged in..."
    end
  end
  
  def admin
     @expired_jobs = Job.count(:all, :conditions => ["start_date < ? and deactivated = 0", Time.now()])
      @expired_students = Student.count(:all, :conditions => ["expires < ? and deactivated = 0", Time.now()])

      @jobs_count = Job.count(:all, :conditions => ["deactivated = 0"])
      @students_count = Student.count(:all, :conditions => ["deactivated = 0"])

      @student_accounts = User.count(:all, :conditions => ["identity = 2"])
      @employer_accounts = User.count(:all, :conditions => ["identity = 3"])
    end
 
 def meet
   @user = User.find_by_id(params[:id]) 
 end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      flash[:warning] = "Username/password not recognized."
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'login')
    flash[:notice] = "Check your email to activate account"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def activate
    @user = User.find_by_activation_code(params[:id])
    if @user and @user.activate
      self.current_user = @user
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Your account has been activated." 
    end
  end
  
  def edit
    @user = User.find(self.current_user.id)
  end
      
  def update
    @user = User.find(self.current_user.id)
      if @user.update_attributes(params[:user])
          flash[:notice] = 'User was successfully updated.'
          redirect_to :action => 'index'
      else
          render :action => 'edit'
      end
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'login')
  end
  
  def forgot_password
      return unless request.post?
      if @user = User.find_by_email(params[:email])
        @user.forgot_password
        @user.save
        redirect_back_or_default(:controller => '/account', :action => 'login')
        flash[:notice] = "Check your email for a reset link" 
      else
        flash[:warning] = "Could not find a user with that email address" 
      end
    end
  
#  def blanket_reset
 #   @user = User.find_all
  #  for @user do
  #    @user.forgot_password
#      @user.save
#    end
#  end

  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        @user.reset_password
        flash[:notice] = current_user.save ? "Password reset" : "Password not reset" 
      else
        flash[:warning] = "Password mismatch" 
      end  
      redirect_back_or_default(:controller => '/account', :action => 'index') 
  rescue
    logger.error "Invalid Reset Code entered" 
    flash[:warning] = "Invalid reset code. Please try again." 
    redirect_back_or_default(:controller => '/account', :action => 'login')
  end
  
  def change_password
      if current_user.authenticated?(params[:old_password])
        current_user.password = params[:password]
        current_user.password_confirmation = params[:password_confirmation]
        begin
          current_user.save!
          flash[:notice] = 'Successfully changed your password.'
        rescue ActiveRecord::RecordInvalid => e
          flash[:error] = "Couldn't change your password: #{e}" 
        end
      else
        flash[:error] = "Couldn't change your password: is that really your current password?" 
      end

      respond_to do |format|
        format.html { redirect_to :action => "edit" }
      end
    end
end
