#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefObjectRelationship
  attr_accessor :type
  attr_accessor :name
  attr_accessor :class_name
  
  def initialize type,name,class_name
    @type = type
    @name = name
    @class_name = class_name
  end
end