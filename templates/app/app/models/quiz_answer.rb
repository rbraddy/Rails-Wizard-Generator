#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class QuizAnswer  < ActiveRecord::Base
  belongs_to :question, :class_name => "QuizQuestion", :foreign_key => "question_id"
end