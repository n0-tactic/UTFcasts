class String
  def integer?
    return true if self =~ /^\d+$/
    true if Integer(self) rescue false
  end
end  
