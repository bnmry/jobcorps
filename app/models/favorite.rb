class Favorite < ActiveRecord::Base
  belongs_to :student
  belongs_to :user
  belongs_to :job
end
