# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def upload(dir,data)
    if data
      name =  data.original_filename
      directory = "#{RAILS_ROOT}/public/data/#{dir}"
      Dir.mkdir(directory,0777) unless File.exist?(directory)
      # create the file path
      name = "#{Digest::SHA1.hexdigest(Time.now.to_s)}_#{name}"        
      path = File.join(directory, name)
      # write the file
      File.open(path, "wb") { |f| f.write(data.read) }
      name
    end
  end
  
  def parse_errors(fields, errors)
    errors.each do |att,m|
      unless fields.include?(att)
        errors.delete att
      end
    end
  end
  
  def has_errors?(fields, errors)
    has = false
    for f in fields
      unless errors.on(f).nil?
        has = true
        break
      end
    end
    has
  end
  
end
