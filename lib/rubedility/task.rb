class Rubedility::Task
  attr_accessor :name, :difficulty, :content, :task_url, :task_reading_url, :tagline

  def initialize(task_row)
    add_task_attributes(task_row)
    @@all.push(self)
  end

  @@all = []

  def self.create_from_collection(task_hash)
    task_hash.each do |task|
      Task.new(task)
    end
  end

  def add_task_attributes(attributes_hash)
    if attributes_hash == nil
      return
    end
    attributes_hash.each do |key, val|
      self.send(("#{key}="), val)
      if key.to_s == "difficulty"
        d = Difficulty.find_or_create(val)
        d.add_task(self)
      end
    end
  end

  def self.all
    @@all
  end

  def self.user_display_one
    print "Enter Task Name:"
    input = gets.strip.downcase
    self.all.each do |task|
      if task.name.downcase==input
        task.display_content
        return nil
      end
    end
    self.display_all
    puts "Try better next time."
  end

  def display_row
    puts "=#{self.name}= (#{self.difficulty})"
    puts "#{self.tagline}\n\n"
  end

  def display_content
    puts "========================================="
    puts "==========#{self.name}=========="
    puts "========================================="
    puts "Difficulty: #{self.difficulty}"
    puts @content
  end

  def self.display_all
    puts "\nAvailable Tasks: \n"
    self.all.each do |task|
      task.display_row
    end
    return nil
  end
end
