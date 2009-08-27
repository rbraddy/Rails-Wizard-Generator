#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
