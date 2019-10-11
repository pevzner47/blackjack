module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def options_arr
      @options_arr ||= []
    end
     
    def validate(name, type, option = nil)
      options_arr << [name, type, option]
    end

    private
    
    def options_arr= (value)
      @options_arr = value
    end

  end

  module InstanceMethods


    def validate!
      self.class.options_arr.each do |args|
        var = instance_variable_get("@#{args[0]}".to_sym)
        type = args[1]
        option = args[2]
        send("validate_#{type}", var, option)
      end
    end
    
    def validate_presence(var, option)
      raise "Значение не может быть пустым или nil" if var.nil? or var == ''
    end

    def validate_format(var, option)
      raise "Неверный формат" if var.to_s !~ option
    end

    def validate_type(var, option)
      raise "Неверный тип аргумента" if !var.is_a? option
    end

    def validate_arr_type(var, option)
      raise "Неверный тип аргумента" if !var.all?(option)
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end