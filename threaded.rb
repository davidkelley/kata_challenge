#!/usr/bin/env ruby

require_relative 'lib/tree'
require_relative 'lib/dictionary'
require 'optparse'

options = {
  :word_length => 6,
  :threads => 10
}

OptionParser.new do |opts|

  opts.banner = "Usage: algorithm.rb [options]"

  opts.on("-d", "--dictionary D", String, "Path to the dictionary file.") do |d|
    options[:dictionary] = d
  end

  opts.on("-w", "--word-length W", Integer, "Length of the word to scan for. Defaults to 6.") do |w|
    options[:word_length] = w
  end

  opts.on("-t", "--threads T", String, "Number of threads to use.") do |t|
    options[:threads] = t
  end

end.parse!

def main(args)

  start = Time.now()

  dict = Dictionary.new(args[:dictionary])

  root = Tree::Root.new

  dict.find_between(2, args[:word_length]-2) { |word| 
    node = root
    word.split("").each do |letter|
      node.insert Tree::Branch.new(letter) unless node.has?(letter)
      node = node[letter]
    end
  }

  matches = []

  words = dict.find_of_length(args[:word_length])

  threads = (0...args[:threads]).map do |i|
    Thread.new(i) do |i|
      index = i
      while index < words.length
        
        paths = Tree.traverse(words[index].split(""), root).map { |path| path.join }

        if paths.length == 2
          matches << {
            :prefix => paths[0],
            :suffix => paths[1]
          }
        end
        index += args[:threads]
      end
    end
  end

  threads.each { |t| t.join }

  matches.each do |match|
    word = match[:prefix] + match[:suffix]
    puts "#{match[:prefix]} + #{match[:suffix]} = #{word}"
  end

  puts "=> Found #{matches.length} matches."

  return Time.now() - start

end

raise OptionParser::MissingArgument if options[:dictionary].nil?

elapsed = main(options)

puts "=> Time Elapsed: #{elapsed} seconds."
