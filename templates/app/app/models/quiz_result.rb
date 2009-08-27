#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class QuizResult  < ActiveRecord::Base

  has_many :answers, :class_name => "QuizAnswer", :foreign_key => "result_id"
end