require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/generator'
require File.dirname(__FILE__) + '/../../lib/parser'

describe Generator do
  before do
    @xml = XmlParser.new 'defs/test.xml'
  end
  
  # it "should create target dir" do    
  #     Generator.new @xml.def
  #     path = "#{RAILS_ROOT}/output/test"
  #     File.should be_exists(path)
  #     File.should be_directory(path)
  #        
  #   end
  #   
  #   it "should generate models" do 
  #     g = Generator.new @xml.def
  #     g.generate_models
  #     path = "#{RAILS_ROOT}/output/test/app/models/account.rb"
  #     File.should be_exists(path)    
  #   end
  #   
  #   it "should generate wizards" do 
  #       g = Generator.new @xml.def
  #       g.generate_wizards
  #       path = "#{RAILS_ROOT}/output/test/app/controllers/wizard_new_account_controller.rb"
  #       File.should be_exists(path)    
  #     end
  it "should generate all" do 
    g = Generator.new @xml.def
    g.generate_migration
    g.generate_wizards
    g.generate_models
    g.generate_forms

  end
    
end