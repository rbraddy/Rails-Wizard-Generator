#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefObjectField
  attr_accessor :name
  attr_accessor :type
  attr_accessor :params
  attr_accessor :default
  
  def initialize name,type,default
    @name = name
    @type = type
    @params = {}
    @default = default
  end
  
  def separated_params
    @params.map do |key,value|
      v = "\"#{value}\""
      ":#{key}=>#{v}"
    end
  end
  
end