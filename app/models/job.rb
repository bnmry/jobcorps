class Job < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :notes, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  validates_presence_of :title, :description, :qualifications, :time_required, :zip, :pay_min, :pay_max, :pay_increment, :start_date
  

  
end