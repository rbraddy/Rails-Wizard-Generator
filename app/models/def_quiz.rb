#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefQuiz
  attr_accessor :title
  attr_accessor :name
  attr_accessor :show_right_answers
  attr_accessor :min_score
  attr_accessor :questions
  
  liquid_methods :name, :title, :questions,:first_step,:last_step,:underscored_name,:show_right_answers?,:min_score
  
  def initialize 
    @questions = []

  end

  def first_step
    @questions.first
  end
  def last_step
    @questions.last
  end 
  def underscored_name
    @name.parameterize('_').to_s
  end
  def class_name
    underscored_name.camelize
  end

  
  def show_right_answers?
    @show_right_answers=='true'
  end
end