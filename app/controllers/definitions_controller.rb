#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#

require File.dirname(__FILE__) + '/../../lib/generator'
require File.dirname(__FILE__) + '/../../lib/parser'

class DefinitionsController < ApplicationController
  def index
    basedir = "#{RAILS_ROOT}/defs/"
    @xmls =  []
    Dir.foreach(basedir) do |f|
      @xmls << f if f.include?('.xml')
    end
  end
  
  def generate
    xml = XmlParser.new "defs/#{params[:id]}.xml"
    g = Generator.new xml.def
    g.generate_migration
    g.generate_wizards
    g.generate_models
    g.generate_forms
    g = nil
    xml = nil
    flash[:notice] = "'#{params[:id]}' Successfully generated..."
    redirect_to :action => "index"
  end
end
