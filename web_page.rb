require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'
require 'nokogiri'


#the dom which contains maximum words would be the main article.
# Pattern Meaning Described in section
# * Matches any element.  Universal selector
# E Matches any E element (i.e., an element of type E). Type selectors
# E F Matches any F element that is a descendant of an E element. Descendant selectors
# E > F Matches any F element that is a child of an element E.  Child selectors
# E:first-child Matches element E when E is the first child of its parent.  The :first-child pseudo-class
# E:link
# E:visited Matches element E if E is the source anchor of a hyperlink of which the target is not yet visited (:link) or already visited (:visited).  The link pseudo-classes
# E:active
# E:hover
# E:focus Matches E during certain user actions.  The dynamic pseudo-classes
# E:lang(c) Matches element of type E if it is in (human) language c (the document language specifies how language is determined).  The :lang() pseudo-class
# E + F Matches any F element immediately preceded by a sibling element E.  Adjacent selectors
# E[foo]  Matches any E element with the "foo" attribute set (whatever the value).  Attribute selectors
# E[foo="warning"]  Matches any E element whose "foo" attribute value is exactly equal to "warning".  Attribute selectors
# E[foo~="warning"] Matches any E element whose "foo" attribute value is a list of space-separated values, one of which is exactly equal to "warning".  Attribute selectors
# E[lang|="en"] Matches any E element whose "lang" attribute has a hyphen-separated list of values beginning (from the left) with "en". Attribute selectors
# DIV.warning Language specific. (In HTML, the same as DIV[class~="warning"].)  Class selectors
# E#myid  Matches any E element with ID equal to "myid".  ID selectors
class WebPage
  attr_accessor :links,:title,:content,:parsed_content, :original_content, :parsed_title, :link_count, :doms_have_contents
  
  def initialize(link = nil)
    if link and url = URI::parse(link)
      @original_content = Nokogiri::HTML(open( link ))
    else
      raise "error !"
    end
  end
  
  def links
    @links = []
    @original_content.css("a").each do |link|
      @links << link
    end
    @links
  end
  
  
  def doms_have_contents
    @doms_have_contents = []
    @original_content.css("*").each do |dom|
      @doms_have_contents << dom unless dom.content.empty?
    end
    return @doms_have_contents
  end
  
  def bigest_dom
    dom = nil
  end
  
  
  def parse_content
    @original_content.css("div ")
  end
  
  def parsed_content
    @parsed_conted
  end
  
  def parsed_title
    @parsed_title
  end 
  
end

wp = WebPage.new("http://www.douban.com")
puts wp.doms_have_contents.first.methods
