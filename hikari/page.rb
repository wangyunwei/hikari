require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'
require 'nokogiri'
require 'dom'


# "%", "/", "<<", "<=>", "==", "===", "=~", ">", "[]", "[]=", "__id__", "__send__", 
# "accept", "add_child", "add_next_sibling", "add_previous_sibling", "after", "all?", "ancestors", "any?", "at", "at_css", "at_xpath", 
# "attr", "attribute", "attribute_nodes", "attribute_with_ns",
# "before", "blank?", 
# "cdata?", "child", "children", "children=", "class", "clone", "collect", "collect_namespaces", "comment?", "content", "content=", 
# "count", "create_cdata", "create_element", "create_entity", "create_external_subset", "create_internal_subset", "create_text_node", 
# "css", "css_path", "cycle", 
# "decorate", "decorate!", "decorators", "delete", "description", "detect", "display", "document", "drop", "drop_while", "dup", 
# "each", "each_cons", "each_slice", "each_with_index", "elem?", "element?", "element_children", "elements", 
# "encode_special_chars", "encoding", "encoding=", "entries", "enum_cons", "enum_for", "enum_slice", "enum_with_index", "eql?", 
# "equal?", "errors", "errors=", "extend", "external_subset", 
# "find", "find_all", "find_index", "first", "first_element_child", "fragment", "fragment?", "freeze", "frozen?", 
# "get_attribute", "grep", "group_by", 
# "has_attribute?", "hash", "html?", 
# "id", "include?", "inject", "inner_html", "inner_html=", "inner_text", "inspect", "instance_eval", "instance_exec", 
# "instance_of?", "instance_variable_defined?", "instance_variable_get", "instance_variable_set", "instance_variables", 
# "internal_subset", "is_a?", 
# "key?", "keys", "kind_of?", 
# "last_element_child", 
# "map", "matches?", "max", "max_by", "member?", "meta_encoding", "meta_encoding=", "method", "methods", "min", "min_by", 
# "minmax", "minmax_by", 
# "name", "name=", "namespace=", "namespace_scopes", "namespaced_key?", "namespaces", "next", "next=", "next_element", 
# "next_sibling", "nil?", "node_name", "node_name=", "node_type", "none?", "object_id", "one?", 
# "parent=", "parse", "partition", "path", "pointer_id", "pretty_print", "previous", "previous=", "previous_element", 
# "previous_sibling", "private_methods", "protected_methods", "public_methods", "read_only?", "reduce", "reject", 
# "remove", "remove_attribute", "remove_namespaces!", "replace", "respond_to?", "reverse_each", "root", "root=", 
# "search", "select", "send", "serialize", "set_attribute", "singleton_methods", "slop!", "sort", "sort_by", 
# "taint", "tainted?", "take", "take_while", "tap", "text", "text?", "to_a", "to_enum", "to_html", "to_s", "to_str", "to_xhtml", 
# "to_xml", "traverse", "type", 
# "unlink", "untaint", "url", 
# "validate", "values", "version", 
# "write_html_to", "write_to", "write_xhtml_to", "write_xml_to", 
# "xml?", "xpath", "zip"




module Hikari
  #Pages after parsed by nokogiri, with its all links, doms with contents parsed out.
  class Page
    attr_reader :doms, :doms_count, :original_content, :candidates, :bigest_dom, :body, :head, :title
    
    def initialize(link)
      if link and url = URI::parse(link)
        @original_content = Nokogiri::HTML(open( link ))
        @doms = []
        @candidates = []
        @body = @original_content.css("body").first
        @head = @original_content.css("head").first
        @title = @original_content.css("title").first.text
        @body.children.each do |dom|
          @doms << Hikari::Dom.new(dom) unless dom.content.nil?  or dom.name == 'script'
        end
        self.gather_candidates
      else
        raise "Error, not a valid url!"
      end
    end
    
    def self.parse(link)
      page = Page.new(link)
    end
    
    def have_article?
      @doms.any? do |dom|
        dom.pure_content.size > 500
      end
    end
    
    def article
      if self.have_article?
        self.bigest_dom.pure_content
      end
    end
    
    
    def gather_candidates
      max = 0
      max_dom = nil
      @doms.each do |dom|
        puts dom.pure_content
        if dom.content and max < dom.content.size
          max = dom.content.size
          max_dom = dom
          puts "gathering candidates:" + dom.pure_content
          @candidates << dom if dom.pure_content.size > 50
        end
      end
      @bigest_dom = max_dom
    end
    
  end
end

page = Hikari::Page.new("http://www.douban.com/group/topic/6629002/")
puts page.candidates.size
page.candidates.each do |dom|
  puts dom.pure_content
end

