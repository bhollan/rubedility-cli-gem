class Rubedility::Task
  attr_accessor :name, :difficulty, :content, :task_url, :task_reading_url, :task_tagline

  def initialize(task_row)
    puts "we've nor instantiated a task!"
  end

  @@all = []

  def initialize
    @@all.push(self)
  end

  def self.create_from_collection(tasks_hash)
    tasks_hash.each do |task|
      Task.new(task)
    end
  end

  def add_task_attributes(attributes_hash)
    if attributes_hash == nil
      return
    end
    attributes_hash.each{|key, val| self.send(("#{key}="), val)}
  end

  def self.all
    @@all
  end
end

