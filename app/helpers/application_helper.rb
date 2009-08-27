#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
module ApplicationHelper
def flash_messages
      messages = []
      %w(notice warning error).each do |msg|
        messages << content_tag(:div, html_escape(flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
      end
      messages
    end
      
end
