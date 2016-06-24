class NotesController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    if is_administrator?
      @note_job_pages, @notes_jobs = paginate(:notes, :per_page => 5, :conditions => ["job_id > 0"], :order => "created_on DESC")
      @note_student_pages, @notes_students = paginate(:notes, :per_page => 5, :conditions => ["student_id > 0"], :order => "created_on DESC")
    else
      @note_job_pages, @notes_jobs = paginate(:notes, :per_page => 5, :conditions => ["user_id = ? and job_id > 0", current_user], :order => "created_on DESC")
      @note_student_pages, @notes_students = paginate(:notes, :per_page => 5, :conditions => ["user_id = ? and student_id > 0", current_user], :order => "created_on DESC")
    end
  end

  def show
    
    if is_administrator?
      @note = Note.find(params[:id])
    elsif
      @note.user_id == current_user.id
      @note = Note.find(params[:id])
    else
      redirect_to(:action => "login", :controller => "user")
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note])
    if @note.save
      flash[:notice] = 'Note was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:notice] = 'Note was successfully updated.'
      redirect_to :action => 'show', :id => @note
    else
      render :action => 'edit'
    end
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
