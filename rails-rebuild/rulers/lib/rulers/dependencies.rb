class Object
  def self.const_missing(c)
    # don't want to get into a loop, so fail if we are calling 
    # from within const_missing itself
    # NOT THREAD SAFE
    return nil if @calling_const_missing
    
    begin
      @calling_const_missing = true
      require Rulers.to_underscore(c.to_s)
      klass = Object.const_get(c)
    ensure
      @calling_const_missing = false
    end
    
    klass
  end
end