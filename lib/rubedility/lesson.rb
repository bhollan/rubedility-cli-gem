class Rubedility::Lesson
  attr_accessor :name, :number, :lesson_url, :reading_url, :tests_started, :tests_solved

  @tasks = []

  def initialize
    puts "we've now instantiated a dumb lesson!"
    @@all.push(self)
  end

  @@all = []

  def self.populate_from_scraping(lessons_hash)
  end

  def self.all
    @@all
  end

  def tasks
    @tasks
  end

  def add_lesson_attributes(lesson_hash)
    if attributes_hash == nil
      return
    end
    attributes_hash.each{|key, val| self.send(("#{key}="), val)}
  end

end

