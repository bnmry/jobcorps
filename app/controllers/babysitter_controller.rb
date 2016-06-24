class BabysitterController < ApplicationController
  before_filter :login_required, :except => [:index, :needed, :available]
  def index
    if current_user.identity == 2
      render :action => "needed"
    elsif current_user.identity == 3
      render :action => "available"
    else
      render :text => "Whoa, you need to pick one", :layout => "standard"
    end
  end
  
  def needed
    @job_pages, @jobs = paginate(:jobs, :per_page => 15, :conditions => "babysitter = 1 and deactivated = 0", :order => "created_at DESC")
  end
  
  def available
     @student_pages, @students = paginate(:students, :per_page => 15, :conditions => "babysitter = 1 and deactivated = 0", :order => "created_at DESC")
  end
end
