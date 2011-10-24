module Hikari
  class Dom
    attr_reader :content, :content_size, :parent, :children, :pure_content, :type, :element
    
    def initialize(element)
      @type = element.name.to_s
      @element = element
      @content = element.content
      @content_size = @content.size
      @parent = element.parent
      @children = element.children
      @pure_content = ""
      @children.each do |child|
        puts "child name: " + child.name
        @pure_content += child.content if child.name == 'text' or child.name == 'p'
      end
    end
    
  end
    
end