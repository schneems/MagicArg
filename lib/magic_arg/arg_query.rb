class MagicArg::ArgQuery
  attr_accessor :raw, :arg_class, :arg_type, :value

  def initialize(string)
    self.raw = string.strip
  end

  def self.parse(string)
    new(string).get_class.get_type
  end

  def get_class
    raw.match(/\[(.*)\]/)
    self.arg_class = $1 ? Kernel.const_get($1) : NilClass
    self
  end

  def get_type
    type = if raw.match(/\*/)
      :splat
    elsif raw.match(/\{.*\}/)
      :hash
    else
      :regular
    end
    self.arg_type = type
    self
  end
end
