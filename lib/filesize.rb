class Filesize
  SI     = {:regexp => /^([\d,.]+)?\s?([kmgtpezy]?)b$/i, :multiplier => 1000, :presuffix => ''}
  BINARY = {:regexp => /^([\d,.]+)?\s?(?:([kmgtpezy])i)?b$/i, :multiplier => 1024, :presuffix => 'i'}
  PREFIXES  = %w{k M G T P E Z Y}

  def initialize(size, type = BINARY)
    @bytes = size.to_i
    @type  = type
  end

  # Returns the size in bytes
  def to_i
    @bytes
  end
  alias_method :to_int, :to_i

  # Returns the size in the given unit, as a float
  def to(unit = 'B')
    to_parts = self.class.parse(unit)
    prefix   = to_parts[:prefix]

    if prefix == 'B' or prefix.empty?
      return to_i.to_f
    end

    to_type = to_parts[:type]
    size    = @bytes

    pos = (PREFIXES.map{|s|s.downcase}.index(prefix.downcase) || -1) + 1

    size = size/(to_type[:multiplier].to_f**(pos)) unless pos < 1
  end
  alias_method :to_f, :to

  # Same as to_f, but as a string, with the unit appended
  def to_s(unit = 'B')
    "%.2f %s" % [to(unit).to_f.to_s, unit]
  end

  # Same as to_s but with an automatic determinition of the most
  # sensible unit
  def pretty
    size = @bytes
    if size < @type[:multiplier]
      unit = "B"
    else
      pos = (Math.log(size) / Math.log(@type[:multiplier])).floor
      pos = PREFIXES.size-1 if pos > PREFIXES.size - 1

      unit = PREFIXES[pos-1].to_s + @type[:presuffix] + "B"
    end

    to_s(unit)
  end

  def +(other)
    self.class.new(@bytes + other.to_i, @type)
  end

  def -(other)
    self.class.new(@bytes - other.to_i, @type)
  end

  def *(other)
    self.class.new(@bytes * other.to_i, @type)
  end

  def /(other)
    result = @bytes / other.to_f
    if other.is_a? Filesize
      result
    else
      self.class.new(result, @type)
    end
  end

  def coerce(other)
    return self, other
  end

  class << self
    def from(arg)
      parts  = parse(arg)
      prefix = parts[:prefix]
      size   = parts[:size]
      type   = parts[:type]

      raise ArgumentError, "Unparseable filesize" unless type

      offset = (PREFIXES.map{|s|s.downcase}.index(prefix.downcase) || -1) + 1

      new(size * (type[:multiplier] ** (offset)), type)
    end

    def parse(string)
      type = nil
      # in this order, so we prefer binary :)
      [BINARY, SI].each { |_type|
        if string =~ _type[:regexp]
          type    =  _type
          break
        end
      }

      prefix = $2 || ''
      size   = ($1 || "0").gsub(", ", "").to_f

      return { :prefix => prefix, :size => size, :type => type}
    end
  end

  Floppy = Filesize.from("1474 KiB")
  CD     = Filesize.from("700 MB")
  DVD_5  = Filesize.from("4.38 GiB")
  DVD    = DVD_5
  DVD_9  = Filesize.from("7.92 GiB")
  DVD_10 = DVD_5 * 2
  DVD_14 = Filesize.from("7.92 GiB") + DVD_5
  DVD_18 = DVD_14 * 2
  ZIP    = Filesize.from("100 MB")
end
