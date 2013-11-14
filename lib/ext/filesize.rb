class Filesize
  ( [ '' ] + 'kMGTPEZY'.chars ).map do |magnitude|
    [ "#{magnitude}B", "#{magnitude}iB" ]
  end.flatten.map(&:to_sym).each do |prefix|
    # Multiply
    define_method prefix do
      self.class.from("#{to_i} #{prefix}")
    end
  end.map { |prefix| "to_#{prefix}" }.map do |prefix|
    prefix.gsub(/([a-z])_([A-Z])/, '\1\2')
  end.map(&:to_sym).each do |method|
    prefix = method.to_s.gsub(/^to_?/, '')
    # Divide
    define_method method do
      self.class.from("#{to_i} B").to(prefix)
    end
  end
end
