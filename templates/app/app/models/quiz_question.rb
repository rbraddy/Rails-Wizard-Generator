#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class QuizQuestion  < ActiveRecord::Base
  belongs_to :quiz, :class_name => "Quiz", :foreign_key => "quiz_id"
end