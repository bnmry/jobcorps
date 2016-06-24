class StudentsController < ApplicationController
  before_filter :login_required, :except => [:index, :list, :show, :tags, :search, :get_results]
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
      if 
        tag_name = params[:id] 
        @students = Tag.find_by_name(tag_name).tagged
      else
      @student_pages, @students = paginate(:students, :per_page => 15, :order => 'created_at DESC', :conditions => "deactivated = 0")
      end
   end

  def show
    @student = Student.find(params[:id])
    if logged_in?
      @user = User.find(:all, :conditions => ["id = ?", current_user])
      @favorites = Favorite.find(:all, :conditions => ["student_id = ?", @student.id])
      @favorite_count = (Favorite.count(:all, :conditions => ["student_id = ?", @student.id])) + (Favorite.count(:all, :conditions => ["user_id = ?", current_user]))
      @notes = Note.count(:all, :conditions => ["student_id = ? and user_id = ?", @student.id, current_user])
    else
      @user = User.find(:all)
    end
  end

  def new
    if is_student?
      @student = Student.new
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:notice] = 'Student was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    if can_edit_student?
      @student = Student.find(params[:id])
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = 'Student was successfully updated.'
      redirect_to :action => 'show', :id => @student
    else
      render :action => 'edit'
    end
  end

  def destroy
    if can_edit_student?
      Student.find(params[:id]).destroy
      redirect_to :action => 'list'
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end
  
  def activate
    render(:layout => false)
    @student = Student.find(params[:id])
    Student.update(@student.id, :deactivated => "0")
  end
  
  def deactivate
    if can_edit_student?
      render(:layout => false)
      @student = Student.find(params[:id])
      Student.update(@student.id, :deactivated => "1")
    else
      flash[:warning] = 'You do not have permission to do that'
    end
  end
      
  def apply  
    if is_employer?
      @student = Student.find(params[:id])
      @notes = Note.find(:all, :conditions => ["user_id = ?", @student.user.id])
      note = Note.new(params[:note])
      email = NoteMailer.deliver_student(note)
      email.set_content_type("text/html")
      if note.save
        render(:text => "Success!  Your note has just been sent to this student.  It was reformatted as a letter, complete with your contact information and return address.")
      else
        render :action => 'new'
      end
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end
  
  def add_to_favs
    if is_employer?
      render(:layout => false)
      @student = Student.find(params[:id])
      @favorite = Favorite.find(:all, :conditions => ["student_id = ?", @student.id])
      new_favorite = Favorite.new(:user_id => current_user.id, :student_id => @student.id)
      new_favorite.save
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end
  
  def report_this_post
    @student = Student.find(params[:id])
    @report = Report.new(params[:report])
    if @report.save
      render(:text => "Thank you for helping to keep JobCorps clean.  We will review the post and take proper action.")
    else
      render(:text => "There is a problem with the reporting feature.  Please contact JobCorps support")
    end
  end
  
  def search
  end
  
  def tags
    @tags = Tag.tags_students(:limit => 100, :order => "name desc", :conditions => ["taggable_type = Student"])
  end

   def get_results
     if request.xhr? 
           if params['search_text'].strip.length > 0 
             terms = params['search_text'].split.collect do |word|  
               "%#{word.downcase}%" 
             end
             @students = Student.find( 
               :all,   
               :conditions => [ 
                 ( ["(LOWER(description) LIKE ?)"] * terms.size ).join(" AND "), 
                 * terms.flatten 
               ]       
             )       
           end     
           render :partial => "search" 
         else    
           redirect_to :action => "index" 
         end 
       end
end
