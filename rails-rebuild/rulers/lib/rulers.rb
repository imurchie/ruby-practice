require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/file_model"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == '/'
        # two options
        case rand(2)
        when 0
          act = :a_quote
          controller = QuotesController.new(env)
        when 1
          act = :index
          controller = HomeController.new(env)
        end
      else
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
      end
      
      begin
        puts "CLASS: #{controller}; ACTION: #{act}"
        
        text = controller.send(act)
      rescue Exception => e
        # relying on Rack to display error for now
        `cat #{e} > debug.txt`;
        raise e
      end
      
      #`echo debug > debug.txt`;
      [200, {'Content-Type' => 'text/html'},
        [text]]
    end
  end
end
