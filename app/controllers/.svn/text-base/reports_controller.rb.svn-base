class ReportsController < ApplicationController
  before_filter :login_required
  layout 'standard'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def jobs
    @reports = Report.find(:all, :conditions => ["resolved = 0 and job_id > 0"])
  end
  
  def students
    @reports = Report.find(:all, :conditions => ["resolved = 0 and student_id > 0"])
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
    if @report.save
      flash[:notice] = 'Report was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      flash[:notice] = 'Report was successfully updated.'
      redirect_to :action => 'show', :id => @report
    else
      render :action => 'edit'
    end
  end

  def destroy
    Report.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def resolve
    render(:layout => false)
    @report = Report.find(params[:id])
    if Report.update(@report.id, :resolved => "1")
      reload_page
    end
  end
end
