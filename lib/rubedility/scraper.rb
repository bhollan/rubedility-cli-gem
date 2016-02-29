require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    binding.pry

    lessons = []
    index.css("").each do |lesson|
      name = card.css("").text
      number = card.css("").text
      lesson_url = "".concat(index_url).concat(card.css("").attr("href").value)
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

