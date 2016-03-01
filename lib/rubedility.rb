class Rubedility

  def initialize
    scrape_index
    scrape_lessons
    #scrape_tasks
    display_greeting
    #display_menu (menu will display from the 'while' loop below)
  end

  def self.list
    puts "this might one day be a list of stuff!"
  end

  def run(commands=nil)
    input = ""
    until input=="exit" || input=="quit" || input=="close"

      case input
      when "list lessons"
        Lesson.display_all

      when "list tasks"
        puts Task.display_all

      when "list stats"
        puts "LESSON STATS"

      when "open lesson"
        Lesson.user_display_one

      when "open task"
        puts "TASK OPENER"

      when "list by difficulty"
        puts "DIFFICULTIES"
        Difficulty.display_all

      when "open reading"
        puts "READING OPENER"

      else
        display_menu

      end
      input = gets.strip
    end
  end

  def scrape_index
    print "fetching index  ..."
    Lesson.populate_from_scraping(Scraper.scrape_index_page('https://codility.com/programmers/lessons/'))
    puts "\n"
  end

  def scrape_lessons
    #this would be an ideal time for some Asynchronous magical powers of awesome
    print "fetching lessons..."
    Lesson.all.each do |lesson|
      attributes_hash, task_array = Scraper.scrape_lesson_page(lesson.lesson_url)
      lesson.add_lesson_attributes(attributes_hash)
      lesson.add_tasks(task_array)
    end
    puts "\n"
  end

  def scrape_tasks
    print "fetching tasks  ..."
    Tasks.all.each do |task|
    end
  end

  def display_greeting
    puts "\nWelcome to Rubedility!"
    puts "Your command line access point for Ruby-flavored Codility lessons and tasks.\n"
  end

  def display_menu
    puts "Commands: '<list/open> <lesson(s)/task(s)/stats/reading>', 'list by difficulty', 'exit'"
    #puts "Commands: 'list lessons', 'open lesson', 'list tasks', 'open task', 'list stats', 'open reading', 'exit'"
  end

end

require 'rubedility/lesson'
require 'rubedility/task'
require 'rubedility/scraper'
require 'rubedility/difficulty'
