$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module NamedAttributeParser
  VERSION = '0.0.1'

  private
  
  def named_attributes(args_list, *list)
    results = []
    names = list; defaults = []

    args = args_list.first.kind_of?(Hash) ? args_list.first : {}

    if names.last.kind_of?(Hash)
      names = list[0..-2]
      defaults = list[-1]
    end

    names.each do |name|
      unless args.has_key?(name)
        raise ArgumentError.new("named argument '#{name}' is not given")
      end 
      value = args[name]
      results << value
    end

    defaults.each do |name, default_value|
      value = default_value
      value = args[name] if args.has_key?(name)
      results << value      
    end

    if block_given?
      yield(*results)
    else 
      return results
    end
  end

end
