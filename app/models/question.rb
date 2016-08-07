class Question < ActiveRecord::Base
  has_many :user_game_questions
  belongs_to :game
end
