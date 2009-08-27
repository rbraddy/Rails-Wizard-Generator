require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/parser'

describe XmlParser do
  before do
    @xml = XmlParser.new 'defs/test.xml'
  end
  
  it "should be valid xml file" do    
    @xml.should be_valid    
  end
  
  it "should be has 3 objects" do    
     @xml.def.objects.size.should equal(3)    
  end  
  
  it "should be has one wizard" do    
     @xml.def.wizards.size.should equal(1)    
  end  
  
  it "should be has one wizard with 4 steps" do    
     @xml.def.wizards[0].steps.size.should equal(4)    
  end  
  
end