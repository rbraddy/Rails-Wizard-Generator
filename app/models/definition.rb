#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class Definition
  attr_accessor :name
  attr_accessor :objects
  attr_accessor :wizards
  attr_accessor :forms

  def initialize 
    @objects = []
    @wizards = []
    @forms = []
  end
end