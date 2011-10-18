require 'rubygems'
require 'net/http'
require 'uri'
require 'nokogiri'


#the dom which contains maximum words would be the main article.

class WebPage
  attr_reader :links,:title,:content,:parsed_content, :original_content, :parsed_title, :link_count
  
  def initialize(link='')
    if link and url = URI::parse(link)
      @original_content = Nokogiri::HTML(open('http://www.google.com/search?q=tenderlove'))
    end
  end
  
  def links
    @links = []
    @original_content.css("a").each do |link|
      @links << 
    end
    @links
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