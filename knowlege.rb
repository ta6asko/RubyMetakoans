def attribute (a, &block)

  if a.is_a?(Hash)
    att = a.keys[0]
    value = a.values[0] 
  else
    att = a 
    value = nil
  end

  str = att.to_s
  ins = '@' + str

  define_method str do 
    if instance_variable_defined?(ins)
      instance_variable_get(ins)
    else 
      instance_variable_set(ins, (block ? instance_eval(&block) : value)) 
    end
  end

  define_method(str + "=") { |val| instance_variable_set(ins, val)}

  define_method(str + "?") {instance_variable_get(ins) ? true : false}
end