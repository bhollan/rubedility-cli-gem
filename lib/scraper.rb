require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    lessons = []
    index.css("div.lessons_list a").each do |lesson|
      binding.pry
      number = lesson.css("div.num").text[-2..-1].to_i
      name = card.css("div.title").text
      lesson_url = "".concat(index_url).concat(lesson.attr("href").value)
      lessons.push({:name=>name, :number=>number, :lesson_url=>lesson_url})
    end
    return lessons
  end

  def self.scrape_lesson_page(lesson_url)
    begin
      lesson = Nokogiri::HTML(open(lesson_url))
      binding.pry
    rescue OpenURI::HTTPError => er
      puts "404, Lesson not found"
      puts lesson_url
      puts er
      return nil
    else
    end
  end

  def self.scrape_task_page(task_url)
    begin
      task = Nokogiri::HTML(open(task_url))
      binding.pry
    rescue OpenURI::HTTPError => er
      puts "404'd!"
      puts task_url
      puts er
      return nil
    else
    end
  end

end

