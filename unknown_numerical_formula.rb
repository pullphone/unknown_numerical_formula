class UnknownNumericalFormura
  def self.calc(input)
    return self._reduce(self._parse(input))
  end

  def self._parse(input)
    parsed = []

    numeric = ''
    input.chars.each do |i|
      if (i =~ /\A-?\d+(.\d+)?\Z/) != nil
        numeric += i
        next
      end

      parsed.push(numeric.to_i)
      parsed.push(i)
      numeric = ''
    end

    parsed.push(numeric.to_i)
    return parsed
  end

  def self._expr(ope, a, b)
    return eval("#{a}#{ope}#{b}")
  end

  def self._reduce(input)
    input_size = input.size
    if input_size == 1
      return input[0]
    end

    left = []
    right = []

    operators = ['*', '+', '&', '|']
    operators.each do |ope|
      ope_index = input.index(ope)
      if ope_index != nil
        ope_index.times do |i|
          left.push(input[i])
        end

        for i in (ope_index + 1)..(input_size - 1)
          right.push(input[i])
        end

        if left.size == 1 && right.size == 1
          return self._expr(ope, left[0], right[0])
        end

        return self._expr(ope, self._reduce(left), self._reduce(right))
      end
    end
  end
end
