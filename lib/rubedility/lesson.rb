class Rubedility::Lesson
  attr_accessor :name, :number, :lesson_url, :reading_url, :tests_started, :tests_solved

  @tasks = []

  def initialize(lesson_hash)
    add_lesson_attributes(lesson_hash)
    @@all.push(self)
  end

  @@all = []

  def self.populate_from_scraping(lessons_array)
    lessons_array.each do |lesson|
      self.new(lesson)
    end
  end

  def self.all
    @@all
  end

  def self.display_all
    puts "Available Lessons: \n"
    self.all.each do |les|
      #puts "#{les.number}. #{les.name} (#{((les.tests_solved.to_f)/(les.tests_started.to_f)).round(2)}%)"
      puts "#{les.number}. #{les.name}"
    end
    return nil
  end

  def add_tasks(task_array)
    task_array.each do |task_row|
      self.tasks.push(Task.new(task_row))
    end
  end

  def tasks
    @tasks
  end

  def add_lesson_attributes(attributes_hash)
    if attributes_hash == nil
      return
    end
    attributes_hash.each{|key, val| self.send(("#{key}="), val)}
  end

end

