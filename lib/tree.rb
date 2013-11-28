# word.split("").each_with_index do |letter, l|
#   if node.has?(letter)
#     node = node[letter]
#     if node.leaf?
#       node = root
#       sub_words << word[i..l]
#       i = l + 1
#       break if word.length - l < 2
#     end
#   else
#     break
#   end
# end


module Tree

  def self.traverse(map, root)
    position = 0
    node = root
    paths = []

    map.each_with_index do |point, index|
      if node.has?(point)
        node = node[point]
        if node.leaf?
          node = root
          paths << map[position..index]
          if map.length - index >= 2
            position = index + 1
          else
            break
          end
        end
      else
        break
      end
    end

    return paths
  end

  class Root
    attr_accessor :nodes

    def initialize
      @nodes = {}
    end

    def has?(key)
      @nodes.keys.include?(key)
    end

    def []
      @nodes.keys
    end

    def [](key)
      @nodes[key]
    end

    def insert(node)
      @nodes[node.edge] = node
    end

  end

  class Branch < Root

    attr_accessor :edge

    def initialize(edge)
      @edge = edge
      super()
    end

    def leaf?
      !@nodes.any?
    end

  end

end