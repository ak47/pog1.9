##
# Add the sanitize! method to the String class
#
class String
  
  ##
  # Sanitize the String *completely* from memory.  This is non-reversible.
  #
  def sanitize
    for i in 0...self.length
      self[i] = 0
    end
    self.delete!("\000")
  end
end
