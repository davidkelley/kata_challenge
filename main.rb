#!/usr/bin/env ruby

require_relative 'lib/tree'
require_relative 'lib/dictionary'
require 'optparse'

options = {
  :word_length => 6
}

OptionParser.new do |opts|

  opts.banner = "Usage: algorithm.rb [options]"

  opts.on("-d", "--dictionary D", String, "Path to the dictionary file.") do |d|
    options[:dictionary] = d
  end

  opts.on("-w", "--word-length W", Integer, "Length of the word to scan for. Defaults to 6.") do |w|
    options[:word_length] = w
  end

end.parse!

def main(args)

  start = Time.now()

  dictionary = Dictionary.new(args[:dictionary])

  root = Tree::Root.new

  dictionary.find_between(2, args[:word_length]-2) { |word| 
    node = root
    word.split("").each do |letter|
      node.insert Tree::Branch.new(letter) unless node.has?(letter)
      node = node[letter]
    end
  }

  matches = 0

  dictionary.find_of_length(args[:word_length]) { |word|

    paths = Tree.traverse(word.split(""), root).map { |path| path.join }

    if paths.length == 2
      matches += 1
      puts "#{paths[0]} + #{paths[1]} = #{word}"
    end

  }

  puts "=> Found #{matches} matches."

  return Time.now() - start

end

raise OptionParser::MissingArgument if options[:dictionary].nil?

elapsed = main(options)

puts "=> Time Elapsed: #{elapsed} seconds."

