class Rubedility::Lesson
  attr_accessor :name, :number, :lesson_url, :reading_url, :tests_started, :tests_solved

  @tasks = []

  def initialize(lesson_hash)
    add_lesson_attributes(lesson_hash)
    @tasks = []
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

  def self.user_display_one
    self.display_all
    print "Select Lesson Number:"
    input = gets.strip.to_i
    self.all.each do |lesson|
      if lesson.number==input
        lesson.display_lesson
        return nil
      end
    end
    puts "Try selecting a correct number next time."
  end

  def display_lesson
    self.tasks.each do |task|
      task.display_row
    end
  end

  def self.display_all
    puts "\nAvailable Lessons: \n"
    self.all.each do |les|
      puts "#{les.number}. #{les.name}"
    end
    puts "\n"
    return nil
  end

  def self.user_display_stats
    self.display_all
    print "Select Lesson Number for stats:"
    input = gets.strip.to_i
    self.all.each do |lesson|
      if lesson.number==input
        lesson.display_stats
        return nil
      end
    end
    return "Try selecting a correct number next time."
  end

  def display_stats
    puts "\n#{self.tests_started} tests have been started from this lesson."
    puts "#{self.tests_solved} tests have been solved from this lesson."
    puts "#{self.tasks.length} task(s) gives an average success rate of #{(self.tests_solved.to_f/self.tests_started.to_f).round(3)*100}%"
  end

  def self.user_open_reading
    self.display_all
    print "Select Lesson Number for reading:"
    input = gets.strip.to_i
    self.all.each do |lesson|
      if lesson.number==input
        #lesson.open_reading
        return lesson.reading_url
      end
    end
    return "Try selecting a correct number next time."
  end

  def open_reading
    puts "launchy: #{@reading_url}"
    launchy @reading_url
  end

  def add_tasks(task_array)
    task_array.each do |task_row|
      self.tasks.push(Rubedility::Task.new(task_row))
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
