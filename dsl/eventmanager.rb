module Practice
  class EventManager
    def initialize(block)
      @setups = []
      @events = {}
      @other_elements = {}
      
      instance_eval(&block)
    end
    
    def evaluate
      @events.each do |name, event_block|
        event = Event.new(name)
        
        @setups.each do |setup_block|
          event.instance_eval(&setup_block)
        end
        
        p @other_elements unless @other_elements.empty?
        
        p event
        
        puts "ALERT: #{name}" if event.instance_eval(&event_block)
      end
    end
    
    private
    def setup(&block)
      @setups << block
    end
    
    private
    def event(name, &block)
      @events[name] = block
    end
    
    
    private
    class Event
      def initialize(name)
        @name = name
      end
    end
  end
end

def describe(str = nil, &block)
  em = Practice::EventManager.new(block)
  
  em.evaluate
end


Dir.glob("*event.rb").each do |file|
  load file
end

