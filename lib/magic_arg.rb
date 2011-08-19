class MagicArg
  attr_accessor :args

  def initialize(args)
    self.args = Args.new(*args)
  end

  def self.parse(args, order_map)
    result = new(args).parse(order_map)
  end

  def parse(order_map)
   return  Parser.new(args, order_map).extract_args
  end

end

require 'magic_arg/args'
require 'magic_arg/arg_query'
require 'magic_arg/parser'
