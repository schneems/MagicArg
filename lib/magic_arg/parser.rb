class MagicArg::Parser
  attr_accessor :args, :arg_queries

  def initialize(args, arg_order_map)
    self.args = args
    self.arg_queries = arg_order_map.split(",").map do |arg_query|
      MagicArg::ArgQuery.parse(arg_query)
    end
  end

  def map_values_to_classes!
    arg_queries.each do |arg_query|
      next if arg_query.arg_class.is_a? NilClass
      if arg_query.arg_type == :splat
        arg_query.value = args.pop_all!(arg_query.arg_class)
      else
        arg_query.value = args.pop!(arg_query.arg_class)
      end
    end
  end

  def map_values_to_regulars!
    arg_queries.each_with_index do |arg_query, index|
      next if arg_query.value.respond_to?(:empty?) ? !arg_query.value.empty? : !arg_query.value.nil?
      if arg_query.arg_type == :regular
        arg_query.value = args[index]
        args[index] = nil
      end
    end
  end

  def map_values_to_splats!
    arg_queries.select {|x| x.arg_type == :splat}.each do |arg_query|
      next if arg_query.value.respond_to?(:empty?) ? !arg_query.value.empty? : !arg_query.value.nil?
      arg_query.value = args.split(NilClass).first
    end
  end

  def map_values_to_hashes!
    arg_queries.select {|x| x.arg_type == :hash }.each do |arg_query|
      next if arg_query.value.respond_to?(:empty?) ? !arg_query.value.empty? : !arg_query.value.nil?
      arg_query.value = args.pop!(Hash)
    end
  end

  def map_values_to_types!
    map_values_to_regulars!
    map_values_to_hashes!
    map_values_to_splats!
  end

  def arg_values
    return *arg_queries.map(&:value)
  end

  def extract_args
    map_values_to_classes!
    map_values_to_types!
    return arg_values
  end
end
