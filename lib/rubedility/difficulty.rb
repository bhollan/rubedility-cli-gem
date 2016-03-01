class Difficulty
  attr_accessor :level
  def initialize(difficulty)
    @level = difficulty
    @@all.push(self)
    @all_tasks = []
  end

  @@all = []
  @all_tasks = []

  def self.all
    @@all
  end

  def all
    @all_tasks
  end

  def display_tasks
    self.all.each do |task|
      puts task.name
    end
  end

  def self.display_all
    self.all.each do |diff|
      puts "\n=====#{diff.level}====="
      diff.display_tasks
      puts "=======================\n"
    end
  end

  def self.find_or_create(task_difficulty)
    self.all.each do |d|
      if d.level == task_difficulty
        return d
      end
    end
    return self.new(task_difficulty)
  end

  def add_task(task)
    self.all.push(task)
  end
end
