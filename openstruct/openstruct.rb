module Practice
  class MyOpenStruct
    def initialize(hash = {})
      @attributes = hash
    end
    
    def ==(other)
      self.attributes == other.attributes
    end
    
    def delete_field(name)
      raise NameError.new("method `#{name}' not defined in MyOpenStruct") if !attributes.include?(name.to_sym)
      
      attributes.delete(name.to_sym)
    end
    
    
    
    def method_missing(name, *args, &block)
      if name =~ /=/
        # setter
        set_attribute(name.to_s.sub("=", "").to_sym, args.first)
      else
        # getter
        get_attribute(name)
      end
    end
    
    protected
    def attributes
      @attributes
    end
    
    private
    def set_attribute(name, value)
      attributes[name] = value
    end
    
    private
    def get_attribute(name)
      attributes[name]
    end
  end
end