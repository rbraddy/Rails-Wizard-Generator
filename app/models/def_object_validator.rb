#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefObjectValidator
  attr_accessor :fields
  attr_accessor :type
  attr_accessor :params
  
  def initialize type,fields
    @fields = fields
    @type = type
    @params = {}
  end
  
  def separated_fields
    # p "#{@fields.split(',').map{|f| ":#{f}"}}"
    @fields.split(',').compact.map{|f| ":#{f}"}.join(',') if @fields
  end
  def separated_params
    @params.map do |key,value|
      v = "\"#{value}\""
      if key=="in"
        v = "%w( #{value.split(',').join(' ')} )"
      elsif key=="maximum" or key=="within" or (key=='with' and type=='format_of')
        v = value
      end
      ":#{key}=>#{v}"
    end
  end
end