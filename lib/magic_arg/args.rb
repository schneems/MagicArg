
class MagicArg::Args < Array
  def initialize(*args)
    super args
  end

  def symbols
    @symbols ||= find(Symbol)
  end

  def hashes
    @hashes ||= find(Hash)
  end


  def arrays
    @arrays ||= find(Array)
  end

  def strings
    @strings ||= find(String)
  end

  def numbers
    @numbers ||= find(Numeric)
  end

  def find(obj)
    if obj.is_a? Class
      map {|x| x if x.is_a? obj }.compact
    else
      map {|x| x == obj }.compact
    end
  end

  def split(obj)
    output_array = [[]]
      each do |x|
        if obj.is_a?(Class) ? x.is_a?(obj) : x == obj
          output_array << [] unless output_array.last.empty?
        else
          output_array.last << x
        end
      end
      output_array
  end

  def pop!(obj)
    value_not_found = true
    val = find(obj).first
    collect! do |x|
      if x == val && value_not_found
        value_not_found = false
        nil ## need to make special nil class?
      else
        x
      end
    end
    return val
  end
  
  def pop_all!(obj)
    values = []
    self.collect! do |x|
      if obj.is_a?(Class) ? x.is_a?(obj) : x == obj
        values << x
        nil
      else
        x
      end
    end
    values
  end

end
