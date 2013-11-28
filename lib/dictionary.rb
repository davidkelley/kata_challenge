#require_relative 'tree'

class Dictionary

  attr_accessor :dictionary

  def initialize(path)
    @dictionary = File.open(path, "rb").read
  end

  def find(reg, &block)
    @dictionary.scan(reg, &block)
  end

  def find_of_length(length, &block)
    find(/^[a-z]{#{length}}$/, &block)
  end

  def find_between(min, max, &block)
    find(/^[a-z]{#{min},#{max}}$/, &block)
  end

end