#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class UserControl
  attr_accessor :type
  attr_accessor :name
  attr_accessor :label
  attr_accessor :object
  attr_accessor :values
  attr_accessor :attributes
  attr_accessor :datasource

  liquid_methods :type, :name, :label, :object, :values, :attributes, :datasource,:mapped_attributes,:datasource_for_render,:underscored_object
  
  def initialize type,name=nil,label=nil,object=nil
    @type = type
    @name = name
    @label = label
    @object = object
    # @values = values
    @attributes = {}
    @datasource = {}
  end
  
  def mapped_attributes
    attributes.map{|k,v| "'#{k}'=>'#{v}'"}.join(',')    
  end
  
  def datasource_for_render
    ",:data=>#{@datasource[:object]}.find(:all).map{|o|[o.#{@datasource[:label]},o.#{@datasource[:id]}]}" unless @datasource.empty?
  end
  
 def underscored_object
   
    object.underscore
  end  
end