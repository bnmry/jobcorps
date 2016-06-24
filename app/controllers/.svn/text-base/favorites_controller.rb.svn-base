class FavoritesController < ApplicationController
  before_filter :login_required
  def index
    if session[:user].identity == 2
      render :action => "jobs"
    elsif session[:user].identity == 3
      render :action => "students"
    else
      render :action => "list"
    end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    if session[:user].identity == 2
      redirect_to :action => "jobs"
    end
    if session[:user].identity == 3
      redirect_to :action => "students"
    end
  end
  
  def jobs
    if is_administrator?
      @favorite_pages, @favorites = paginate(:favorites, :per_page => 10, :conditions => ["job_id > 0"], :order => "created_on DESC")
      @favorite_count = Favorite.count(:all, :conditions => ["job_id > 0"], :order => "created_on DESC")
    else
      @favorite_pages, @favorites = paginate(:favorites, :per_page => 10, :conditions => ["user_id = ? and job_id > 0", current_user], :order => "created_on DESC")
      @favorite_count = Favorite.count(:all, :conditions => ["user_id = ? and job_id > 0", current_user], :order => "created_on DESC")
    end
  end
  
  def students
    if is_administrator?
      @favorite_pages, @favorites = paginate(:favorites, :per_page => 10, :conditions => ["student_id > 0"], :order => "created_on DESC")
      @favorite_count = Favorite.count(:all, :conditions => ["student_id > 0"], :order => "created_on DESC")
    else
      @favorite_pages, @favorites = paginate(:favorites, :per_page => 10, :conditions => ["user_id = ? and student_id > 0", current_user], :order => "created_on DESC")
      @favorite_count = Favorite.count(:all, :conditions => ["user_id = ? and student_id > 0", current_user], :order => "created_on DESC")
    end
    
  end

  def show
    @favorite = Favorite.find(params[:id])
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(params[:favorite])
    if @favorite.save
      flash[:notice] = 'Favorite was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def destroy
    Favorite.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
