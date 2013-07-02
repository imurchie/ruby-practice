require "erubis"
require_relative "file_model"

module Rulers
  class Controller
    include Rulers::Model
    
    attr_reader :env
    
    def initialize(env)
      @env = env
    end
    
    def render(view_name, locals = {})
      filename  = File.join("app", "views", controller_name, "#{view_name}.html.erb")
      template  = File.read(filename)
      eruby     = Erubis::Eruby.new(template)
      
      add_instance_variables(eruby)
      
      eruby.result(locals.merge(:env => env))
    end
    
    def controller_name
      klass = self.class.to_s.gsub(/Controller$/, "")
      
      Rulers.to_underscore(klass)
    end
    
    private
    def add_instance_variables(eruby)
      self.instance_variables.each do |key|
        @key.to_s.sub!(/^@/, "")
        
        eruby.instance_variable_set(key, self.instance_variable_get(key))
      end
    end
  end
end