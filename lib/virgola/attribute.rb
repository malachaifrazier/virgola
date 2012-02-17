class Boolean; end

module Virgola

  Types = [String, Float, Time, Date, DateTime, Integer, Boolean]


  class Attribute
    attr_accessor :name, :type, :options

    def initialize(name,type=String,*args)
      @name    = name
      @type    = type
      @value   = nil
      @options = args.extract_options!
    end

    def map(mapped_object, value)
      mapped_object.send("#{self.name}=", cast(value))
    end

    #
    # Based on <https://github.com/jnunemaker/happymapper/blob/master/lib/happymapper/item.rb#L84>
    #
    def cast(value)
      if    self.type == Float    then value.to_f
      elsif self.type == Time     then Time.parse(value)
      elsif self.type == Date     then Date.parse(value)
      elsif self.type == DateTime then DateTime.parse(value)
      elsif self.type == Boolean  then ['true', 't'].include?(value.to_s.downcase)
      elsif self.type == Integer  then
        # ganked from happymapper :)
        value_to_i = value.to_i
        if value_to_i == 0 && value != '0'
          value_to_s = value.to_s
          begin
            Integer(value_to_s =~ /^(\d+)/ ? $1 : value_to_s)
          rescue ArgumentError
            nil
          end
        else
          value_to_i
        end
      else
        value
      end
    rescue
      value
    end

    def ==(attribute)
      return false unless attribute.is_a?(Attribute)
      self.name == attribute.name && self.value == attribute.value
    end
  end

end