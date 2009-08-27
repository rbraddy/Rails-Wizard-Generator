require "erb"


class ErbTemplate
   attr_reader :args, :text
   def initialize(file)
      @text = File.read(file)
   end
   def exec(args={})
      template = ERB.new(@text)
      result = template.result(binding)
      # result.gsub(/\n$/,'')
      result
   end
end
