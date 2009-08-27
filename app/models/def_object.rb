#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class DefObject
  attr_accessor :class_name
  attr_accessor :class_desc
  attr_accessor :table_name
  attr_accessor :relationships
  attr_accessor :fields
  attr_accessor :validators
  attr_accessor :predefined_rows
  
  def initialize 
    @relationships = []
    @fields = []
    @validators = []
    @predefined_rows = []
  end
  
  def parsed_validators
    @validators.map do |val|
      case val.type
      when "format_of_email"
        val.type = "format_of"
        val.params["with"] = '/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i'
      when "format_of_phone"
        val.type = "format_of"
        val.params["with"] = '/^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/i'        
      end
      val
    end
  end
end