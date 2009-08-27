#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefQuizQuestion
  attr_accessor :has_finish_button
  attr_accessor :title
  attr_accessor :name
  attr_accessor :image
  attr_accessor :help_link
  attr_accessor :control
  attr_accessor :quiz
  attr_accessor :seq
  attr_accessor :right_answer
  attr_accessor :text
  
  liquid_methods :name, :title, :image, :help_link,:control,:quiz,:seq,:has_finish_button?,:underscored_name,:last_step?,:first_step?,:next_step,:prev_step,:image_path,:right_answer,:text
    
  def initialize
    # @controls = []
  end
  
  def has_finish_button?
    @has_finish_button
  end
  
  def underscored_name
    @name.parameterize('_').to_s
  end
  def last_step?
    @quiz.last_step.name == @name
  end
  def first_step?
    r = @quiz.first_step.name == @name
    r
  end
  def next_step
    @quiz.questions[@seq+1] if @quiz.questions[@seq+1]
  end
  def prev_step
    @quiz.questions[@seq-1] if @quiz.questions[@seq-1]
  end
  
  def image_path
    @image
  end
end