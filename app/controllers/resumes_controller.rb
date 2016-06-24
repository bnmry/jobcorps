class ResumesController < ApplicationController
  def get
    @resume = Resume.new
  end
  
  def save
    @resume = Resume.new(params[:resume])
    if @resume.save
      redirect_to(:action => 'show', :id => @resume.id)
    else
      render(:action => :get)
    end
  end
  
  def resume
    @resume = Resume.find(params[:id])
    send_data(@resume.data,
      :filename => @resume.name,
      :type => @resume.content_type,
      :disposition => "inline")
  end
  
  def show
    @resume = Resume.find(params[:id])
  end
end
