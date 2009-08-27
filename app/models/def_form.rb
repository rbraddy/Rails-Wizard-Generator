#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefForm
  attr_accessor :name
  attr_accessor :title
  attr_accessor :object
  attr_accessor :url
  attr_accessor :controls

  liquid_methods :name, :title, :url, :object,:controls,:underscored_name,:underscored_object

  
  def initialize name,title,object,url
    @controls = []
    @name = name
    @title = title
    @object = object
    @url = url
  end

  def underscored_name
    @name.parameterize('_').to_s
  end
  def class_name
    underscored_name.camelize
  end
  
  
  def object_control_names
    @controls.map do |c|
      c.name if c.name
    end
  end
  
  def file_controls
    @controls.select{|c| c.type == 'file'}.compact
  end  
  
  def underscored_object
   
    object.underscore
  end
end