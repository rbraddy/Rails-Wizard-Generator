#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefWizardStep
  attr_accessor :has_finish_button
  attr_accessor :title
  attr_accessor :name
  attr_accessor :image
  attr_accessor :help_link
  attr_accessor :controls
  attr_accessor :object
  attr_accessor :wizard
  attr_accessor :seq
  
  liquid_methods :name, :title, :image, :help_link,:controls,:object,:wizard,:seq,:has_finish_button,:has_finish_button?,:underscored_name,:last_step?,:first_step?,:next_step,:prev_step,:image_path,:underscored_object
    
  def initialize has_finish_button=false,title=nil,image=nil,help_link=nil
    @has_finish_button = has_finish_button
    @title = title
    @image = image
    @help_link = help_link
    @controls = []
  end
  
  def has_finish_button?
    @has_finish_button
  end
  
  def underscored_name
    @name.parameterize('_').to_s
  end
  def last_step?
    @wizard.last_step.name == @name
  end
  def first_step?
    r = @wizard.first_step.name == @name
    r
  end
  def next_step
    @wizard.steps[@seq+1] if @wizard.steps[@seq+1]
  end
  def prev_step
    @wizard.steps[@seq-1] if @wizard.steps[@seq-1]
  end
  
  def object_control_names
    @controls.map do |c|
      c.name if c.name
    end
  end
  
  def file_controls
    @controls.select{|c| c.type == 'file'}.compact
  end
  
  def image_path
    @image
  end
 def underscored_object
   
    object.underscore
  end  
end