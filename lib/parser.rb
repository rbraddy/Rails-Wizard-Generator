#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
require 'rexml/document'


class XmlParser
  # attr file
  attr_reader :def
  
  def initialize file
    @file = file
    @def = Definition.new
    parse
  end
  
  
  def parse
    path = File.new("#{RAILS_ROOT}/#{@file}")
    doc = REXML::Document.new(path)
    @root = doc.root    
    @def.name = @root.attributes['appdir'];
    @root.each_element('//object') do |object| 
      obj = DefObject.new
      object.each_element('classname'){|el| obj.class_name = el.text};
      object.each_element('classdesc'){|el| obj.class_desc = el.text};
      object.each_element('tablename'){|el| obj.table_name = el.text};
      object.each_element('relationships/relationship'){|el| obj.relationships << DefObjectRelationship.new(el.attributes['type'], el.text,el.attributes['classname'])};
      object.each_element('fields/field') do |el| 
        f = DefObjectField.new(el.attributes['name'],el.attributes['type'],  el.text)
        el.each_element('params/param') do |el2|
          f.params[el2.attributes['name']] = el2.text
        end        
        obj.fields << f
      end
      object.each_element('validators/validator') do |el|
        v = DefObjectValidator.new(el.attributes['type'],el.attributes['fields'])
        el.each_element('params/param') do |el2|
          v.params[el2.attributes['name']] = el2.text
        end
        obj.validators << v
      end

      object.each_element('data/row') do |el|
        row = {}
        el.each_element('fields/field') do |el2|
          row[el2.attributes['name']] = el2.text
        end
        obj.predefined_rows << row
      end

      @def.objects << obj      
    end
    
    # wizards
    @root.each_element('//wizard') do |wizard| 
      wiz = DefWizard.new
      wiz.name = wizard.attributes['name']
      wizard.each_element('title'){|el| wiz.title = el.text};
      wizard.each_element('image'){|el| wiz.image = el.text};
      wizard.each_element('overview'){|el| wiz.overview = el.text};
      i = 0
      wizard.each_element('steps/wizard-step') do |el| 
        step = DefWizardStep.new        
        step.has_finish_button = el.attributes['has-finish-button'] == 'true'
        step.name = el.attributes['name']
        step.object = el.attributes['object']
        step.wizard = wiz
        step.seq = i
        i = i+1
        el.each_element('title'){|el2| step.title = el2.text};
        el.each_element('image'){|el2| step.image = el2.text};
        el.each_element('help-link'){|el2| step.help_link = el2.text};
        el.each_element('controls/user-control') do |el2|
          control = DefWizardControl.new(el2.attributes['type'],
                      el2.attributes['name'],
                      el2.attributes['label'],
                      el2.attributes['object']);
          if el2.attributes['datasource']
            match = el2.attributes['datasource'].match(/(.*)\.(.*):(.*)/)                      
            control.datasource[:object] = match[1]
            control.datasource[:id] = match[2]
            control.datasource[:label] = match[3]
          end
          el2.each_element('value'){|el3| control.values = el3.text}
          el2.each_element('attributes/attribute') do |el3|
            control.attributes[el3.attributes['name']] = el3.text
          end
          step.controls << control
        end 
        wiz.steps << step

      end
   
      @def.wizards << wiz
      end
      
      # forms
      @root.each_element('//form') do |el| 
        form = DefForm.new el.attributes['name'],el.attributes['title'],el.attributes['object'],el.attributes['url']
        el.each_element('controls/user-control') do |el2|
          control = DefFormControl.new(el2.attributes['type'],
                      el2.attributes['name'],
                      el2.attributes['label'],
                      el2.attributes['object']);
          el2.each_element('value'){|el3| control.values = el3.text}
          el2.each_element('attributes/attribute') do |el3|
            control.attributes[el3.attributes['name']] = el3.text
          end
          form.controls << control            
        end 
        @def.forms << form
    end
    
  end
  
  def valid?
   !@root.attributes['appname'].nil?   
  end
  
  
  
end