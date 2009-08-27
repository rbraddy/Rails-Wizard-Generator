#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefWizard
  attr_accessor :name
  attr_accessor :title
  attr_accessor :image
  attr_accessor :overview
  attr_accessor :steps

  liquid_methods :name, :title, :image, :overview,:steps,:first_step,:last_step,:underscored_name
  
  def initialize 
    @steps = []

  end

  def first_step
    @steps.first
  end
  def last_step
    @steps.last
  end 
  def underscored_name
    @name.parameterize('_').to_s
  end
  def class_name
    underscored_name.camelize
  end


end