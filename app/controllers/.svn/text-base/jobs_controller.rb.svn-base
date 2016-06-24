class JobsController < ApplicationController
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
        @jobs = Tag.find_by_name(tag_name).tagged
      else
        @job_pages, @jobs = paginate(:jobs, :per_page => 15, :order => 'created_at DESC', :conditions => "deactivated = 0")
      end
  end

  def show
    @job = Job.find(params[:id])
    if logged_in?
      @user = User.find(:all, :conditions => ["id = ?", current_user])
      @favorites = Favorite.find(:all, :conditions => ["job_id = ?", @job.id])
      @favorite_count = Favorite.count(:all, :conditions => ["job_id = ?", @job.id])
      @notes = Note.count(:all, :conditions => ["job_id = ? and user_id = ?", @job.id, current_user])
    else
      @user = User.find(:all)
    end
  end

  def new
    if is_employer?
      @job = Job.new
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end

  def create
    if is_employer?
      @job = Job.new(params[:job])
      if @job.save
        flash[:notice] = 'Job was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to create jobs'
    end
  end

  def edit
    if can_edit_job?
      @job = Job.find(params[:id])
    else
      redirect_to :action => 'list'
      flash[:warning] = 'You do not have permission to do that'
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = 'Job was successfully updated.'
      redirect_to :action => 'show', :id => @job
    else
      render :action => 'edit'
    end
  end

  def destroy
    if can_edit_job?
      Job.find(params[:id]).destroy
      redirect_to :action => 'list'
    else
      redirect_to :action => 'show'
      flash[:warning] = 'You do not have permission to do that'
    end
  end
  
  def activate
    if can_edit_job?
      render(:layout => false)
      @job = Job.find(params[:id])
      Job.update(@job.id, :deactivated => "0")
    else
      redirect_to :action => 'show'
      flash[:warning] = 'You do not have permission to do that'
    end
  end
  
  def deactivate
    render(:layout => false)
    @job = Job.find(params[:id])
    Job.update(@job.id, :deactivated => "1")
  end
      
  def apply
    @job = Job.find(params[:id])
    @notes = Note.find(:all, :conditions => ["user_id = ?", @job.user.id])
    note = Note.new(params[:note])
    email = NoteMailer.deliver_employer(note)
    email.set_content_type("text/html")
    #render(:text => "<pre>" + email.encoded + "</pre>")
    if note.save
      render(:text => "Thanks!  We just sent your note to the employer with your contact information.  Hopefully, they will get back to you.  If you're interested in sending another note, just come back to the job posting.  We'll first remind you that you've already sent them one, though. Five points for handy reminders.")
    else
      render :action => 'new'
    end
  end
  
  def add_to_favs
    render(:layout => false)
    @job = Job.find(params[:id])
    @favorite = Favorite.find(:all, :conditions => ["job_id = ?", @job.id])
    new_favorite = Favorite.new(:user_id => current_user.id, :job_id => @job.id)
    new_favorite.save
  end
  
  def report_this_post
    @job = Job.find(params[:id])
    @report = Report.new(params[:report])
    if @report.save
      render(:text => "Thank you for helping to keep JobCorps clean.  We will review the post and take proper action.")
    else
      render(:text => "There is a problem with the reporting feature.  Please contact JobCorps support")
    end
  end
  
  def search
  end
  
  def get_results
    @title = "Jobs Live Search"
    if request.xhr? 
          if params['search_text'].strip.length > 0 
            terms = params['search_text'].split.collect do |word|  
              "%#{word.downcase}%" 
            end
            @jobs = Job.find( 
               :all,
               :order => "created_at DESC",
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
  
  def tags
    @tags = Tag.tags_jobs(:limit => 100, :order => "name desc")
  end
  
  def lookup_geocodes
      # your list of places. In a real app, this would come from the database,
      # and have more robust descriptions
      @job = Job.find(:all, :conditions => ["description = 0"])
      places = [
       @job.each do
        {:address => (@job.zip), :description => (@job.description)}
       end
       ]
      

      # this loop will do the geo lookup for each place
      places.each_with_index do |place,index|
        # get the geocode by calling our own get_geocode(address) method
        geocode = get_geocode place[:address]

        # geo_code is now a hash with keys :latitude and :longitude
        # place these values back into our "database" (array of hashes)
        place[:latitude]=geocode[:latitude]
        place[:longitude]=geocode[:longitude]    

      end

      #place the result in the session so we can use it for display
      session[:places] = places

      #let the user know the lookup went ok
      render :text=> 'Looked up the geocodes for '+places.length.to_s+
  	' address and stored the result in the session . . .'

    end

    def map
      # all we're going to do is loop through the @places array on the page
      @places=session[:places]
    end

    private
    def get_geocode(address)
      logger.debug 'starting geocoder call for address: '+address
      # this is where we call the geocoding web service
      server = XMLRPC::Client.new2('http://rpc.geocoder.us/service/xmlrpc')
      result = server.call2('geocode', address)
      logger.debug "Geocode call: "+result.inspect

      return {:success=> true, :latitude=> result[1][0]['lat'], 
  		:longitude=> result[1][0]['long']}
    end
  
end