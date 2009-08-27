class Quiz  < ActiveRecord::Base
  has_many :questions, :class_name => "QuizQuestion", :foreign_key => "quiz_id"
  has_many :results, :class_name => "QuizResult", :foreign_key => "quiz_id"
end