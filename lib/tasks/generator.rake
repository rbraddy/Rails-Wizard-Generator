require File.dirname(__FILE__) + '/../../lib/generator'
require File.dirname(__FILE__) + '/../../lib/parser'

namespace :generator do

    desc "Generate sites from all xml def files"
    task :run => :environment do
      basedir = "#{RAILS_ROOT}/defs/"
      xmls =  []
      Dir.foreach(basedir) do |f|
        xmls << f if f.include?('.xml')
      end
      xmls.each do |xml_file|
        xml = XmlParser.new "defs/#{xml_file}"
        g = Generator.new xml.def
        g.generate_migration
        g.generate_wizards
        g.generate_models
        g.generate_forms
      end
    end

end