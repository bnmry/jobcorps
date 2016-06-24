class WelcomeController < ApplicationController
  
  def index
    @jobs = Job.find(:all, :conditions => "deactivated = 0", :order => "created_at DESC", :limit => 5)
    @students = Student.find(:all, :conditions => "deactivated = 0", :order => "created_at DESC", :limit => 5)
    
  end
  
  def students
    @jobs_count = User.count(:all, :conditions => ["identity = 3"])
  end
  
  def employers
    @students_count = User.count(:all, :conditions => ["identity = 2"])
  end
  
end
