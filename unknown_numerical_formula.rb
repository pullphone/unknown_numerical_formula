class UnknownNumericalFormura
  @@operators = ['*', '+', '&', '|']

  class << self
    def calc(input)
      return _reduce(self._parse(input))
    end
  
    def _parse(input)
      parsed_input = []
      numeric_str = ''
  
      input.chars.each {|char| parsed_input, numeric_str = _parse_char(parsed_input, numeric_str, char)}
      parsed_input.push(numeric_str.to_i)
  
      return parsed_input
    end
  
    def _parse_char(parsed_input, numeric_str, char)
      if (char =~ /[0-9]/) == nil
        parsed_input.push(numeric_str.to_i)
        parsed_input.push(char)
        numeric_str = ''
      else
        numeric_str += char
      end
  
      return parsed_input, numeric_str
    end
  
    def _reduce(input)
      input_size = input.size
      if input_size == 1
        return input[0]
      end
  
      @@operators.each do |operator|
        result = _operate(input, operator)
        return result if result != false
      end
    end
  
    def _operate(input, operator)
      ope_index = input.index(operator)
      if ope_index == nil
        return false
      end
  
      left, right = _divide_by_index(input, ope_index)
  
      if left.size == 1 && right.size == 1
        return _expr(operator, left[0], right[0])
      end
  
      return _expr(operator, self._reduce(left), self._reduce(right))
    end
  
    def _divide_by_index(input, index)
      left = input.slice!(0..index)
      left.pop
      return left, input
    end
  
    def _expr(operator, a, b)
      return eval("#{a}#{operator}#{b}")
    end
  end
end
