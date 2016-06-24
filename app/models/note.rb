class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  belongs_to :student
end
