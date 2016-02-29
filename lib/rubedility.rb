require 'rubedility/lesson'
require 'rubedility/task'
require 'rubedility/scraper'

class Rubedility

  def initialize
    scrape_index
    #scrape_lessons
    #scrape_tasks
    display_greeting
    display_menu
  end

  def self.list
    puts "this might one day be a list of stuff!"
  end

  def run(commands=nil)
    puts "we're running"
  end

  def display_greeting
    puts "Welcome to Rubedility!"
    puts "Your command line access point for Ruby-flavored Codility lessons and tasks."
  end

  def display_menu
    puts "You can 'list <things>'"
  end

  def scrape_index
    Lesson.populate_from_scraping(Scraper.scrape_index_page('https://codility.com/programmers/lessons/'))
  end

  def scrape_lessons
    Lesson.new
  end

  def scrape_tasks
    Task.new
  end

end
