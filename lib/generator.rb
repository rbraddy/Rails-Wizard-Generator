#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
require 'fileutils'
require "erb"
require "find"

class Generator
  include FileUtils

  def initialize app_def
    @source_dir = "#{RAILS_ROOT}/templates/app"
    @source_site_dir = "#{RAILS_ROOT}/templates/sites/#{app_def.name}"
    @target_dir = "#{RAILS_ROOT}/output/#{app_def.name}"
    @def = app_def
    p "CREATING FILE STRUCTURE...."
    prepare_structure
  end

  def generate_models
    @def.objects.each do |obj|
      data = ERB.new(File.read("#{@source_dir}/app/models/model.rb.template")).result(binding)
      path = File.join("#{@target_dir}/app/models/", "#{obj.class_name.downcase}.rb")
      File.open(path, "wb"){ |f| f.write(data) }
      # p "data=#{data}"
      # file = File.new("#{@target_dir}/app/models/#{obj.class_name.downcase}.rb",  "w+")
      # file.puts data
      p "GENERATING MODEL: #{obj.class_name.downcase}.rb ...."
    end    
  end

  def generate_migration
    i = 2;
    @def.objects.each do |obj|
      data = ERB.new(File.read("#{@source_dir}/db/migrate/migration.rb.template")).result(binding)
      path = File.join("#{@target_dir}/db/migrate/", "#{'%.3d' % i}_create_#{obj.class_name.tableize}.rb")
      File.open(path, "wb"){ |f| f.write(data) }
      # p "data=#{data}"
      # file = File.new("#{@target_dir}/db/migrate/#{'%.3d' % i}_create_#{obj.class_name.tableize}.rb",  "w+")
      # file.puts data
      p "GENERATING MIGRATION: #{'%.3d' % i}_create_#{obj.class_name.tableize}.rb ...."      
      i += 1
    end
  end
  
  def generate_wizards
    generate_wizard_controllers
    generate_wizard_views
    
  end

  def generate_forms
    generate_forms_controllers
    generate_forms_views
    
  end

  
  private 
  def prepare_structure
    FileUtils.rm_rf @target_dir
    cp_r @source_dir, @target_dir
    FileUtils.rm_rf "#{@target_dir}/public/images/.svn"
    FileUtils.rm_rf "#{@target_dir}/public/stylesheets/.svn"
    if File.exist? @source_site_dir
      cp_r "#{@source_site_dir}/images/", "#{@target_dir}/public/"
      cp_r "#{@source_site_dir}/stylesheets", "#{@target_dir}/public/"    
    end
    
    FileUtils.rm_rf "#{@target_dir}/app/views/layouts/.svn"
    FileUtils.rm_rf "#{@target_dir}/app/views/controls/.svn"
    if File.exist? @source_site_dir
      cp_r "#{@source_site_dir}/views/layouts", "#{@target_dir}/app/views/"
      cp_r "#{@source_site_dir}/views/controls", "#{@target_dir}/app/views/"    
    end
    p "delete templates"
    File.delete "#{@target_dir}/app/views/form.erb.template"
    # File.delete "#{@target_dir}/app/views/form.erb.template_old"
    File.delete "#{@target_dir}/app/views/wizard.erb.template"
    File.delete "#{@target_dir}/app/controllers/wizard_controller.rb.template"
    File.delete "#{@target_dir}/app/controllers/form_controller.rb.template"
    File.delete "#{@target_dir}/app/models/model.rb.template"
    File.delete "#{@target_dir}/db/migrate/migration.rb.template"
    
    datap = ERB.new(File.read("#{@source_dir}/app/views/page/index.html.erb")).result(binding)
    filep = File.new("#{@target_dir}/app/views/page/index.html.erb",  "w+")
    filep.puts datap
  end
  
  def generate_wizard_controllers
    @def.wizards.each do |wizard|
      def_f = "#{@source_dir}/app/controllers/wizard_controller.rb.template"
      # cus_f = "#{@source_site_dir}/controllers/wizard_controller.rb.template"
      data = ERB.new(File.read(def_f)).result(binding)
      file = File.new("#{@target_dir}/app/controllers/wizard_#{wizard.underscored_name}_controller.rb",  "w+")
      file.puts data
      p "GENERATING WIZARD: ...."         
    end
       
  end
  def generate_wizard_views
    def_f = "#{@source_dir}/app/views/wizard.erb.template"
    cus_f = "#{@source_site_dir}/views/wizard.erb.template"
    f = (File.exist?(cus_f) ? cus_f : def_f)
    @def.wizards.each do |wizard|
      wiz_dir = "#{@target_dir}/app/views/wizard_#{wizard.underscored_name}"
      Dir.mkdir(wiz_dir,0777)
      wizard.steps.each do |step|        
        # data = ERB.new(File.read(f)).result(binding)      
        data = Liquid::Template.parse(File.read(f)).render 'step' => step,'wizard'=>wizard        
        file = File.new("#{wiz_dir}/#{step.underscored_name}.html.erb",  "w+")
        file.puts data
      end
    end
  end
  def generate_forms_controllers
    @def.forms.each do |form|
      data = ERB.new(File.read("#{@source_dir}/app/controllers/form_controller.rb.template")).result(binding)
      file = File.new("#{@target_dir}/app/controllers/form_#{form.underscored_name}_controller.rb",  "w+")
      file.puts data
      p "GENERATING FORM: ...."         
    end
      
  end
  def generate_forms_views
    def_f = "#{@source_dir}/app/views/form.erb.template"
    cus_f = "#{@source_site_dir}/views/form.erb.template"
    f = (File.exist?(cus_f) ? cus_f : def_f)
    
    @def.forms.each do |form|
      wiz_dir = "#{@target_dir}/app/views/form_#{form.underscored_name}"
      Dir.mkdir(wiz_dir,0777)

      # data = ERB.new(File.read(f)).result(binding)      
      data = Liquid::Template.parse(File.read(f)).render 'form' => form
      file = File.new("#{wiz_dir}/form.html.erb",  "w+")
      file.puts data

    end
  end
  
end

