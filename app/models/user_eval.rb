class UserEval < ActiveRecord::Base
  belongs_to :eval
  belongs_to :user
end
