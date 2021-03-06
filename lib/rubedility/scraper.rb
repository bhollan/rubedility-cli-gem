require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    lessons = []
    index.css("div.lessons_list a").each do |lesson|
      print "."
      name = lesson.css("div.title").text
      number = lesson.css("div.num").text.delete("Lesson").to_i
      lesson_url = "".concat(index_url).concat(lesson.attr("href").split("/").last)
      lessons.push({:name=>name, :number=>number, :lesson_url=>lesson_url})
    end

    return lessons
  end

  def self.scrape_lesson_page(lesson_url)
    begin
      print "."
      lesson = Nokogiri::HTML(open(lesson_url))
      if lesson.css("a#readings").length > 0
        reading_url = lesson.css("a#readings").attr("href").value
      end
      tests_started = lesson.css("span.started span.num").text.to_i
      tests_solved = lesson.css("span.finished span.num").text.to_i
      task_hashes_array = []
      lesson.css("div.task-box").each do |task_row|
        name = task_row.css("h4.title").text.strip
        #url is just the last 'piece' of the task URL
        url = task_row.css("a").attr("href").text
        #have to add that to the end of the 'real' URL, but take off part of it
        task_url = lesson_url.split("/")[0..2].join("/").concat(url)
        difficulty = task_row.css("div.difficulty").text.strip
        tagline = task_row.css("div.synopsis").text.strip
        task_hashes_array.push({:name=>name, :task_url=>task_url, :difficulty=>difficulty, :tagline=>tagline, :task_reading_url=>reading_url})
      end
      lesson_details = {:reading_url=>reading_url, :tests_started=>tests_started, :tests_solved=>tests_solved}
      #return [hash-of-lesson-details, array-of-task-detail-hashes]
      return [lesson_details, task_hashes_array]
    rescue OpenURI::HTTPError => er
      puts "404, Lesson not found"
      puts lesson_url
      puts er
      return nil
    else
    end
  end

  def self.scrape_task_page(task_url)
    print "."
    begin
      task = Nokogiri::HTML(open(task_url))
      content = task.css("div.desc-rb-en div").first.text
      #the way they have the content is not best for command line display.
      #some '\n' and some '\n\n', command line looks better with '\n\n'
      #substitube singles for doubles
      content.gsub!(/[\n]+/,"\n")
      #substitute doubles for singles
      content.gsub!(/[\n]/,"\n\n")
      return {:content=>content}
    rescue OpenURI::HTTPError => er
      puts "404'd!"
      puts task_url
      puts er
      return nil
    else
    end
  end

end

