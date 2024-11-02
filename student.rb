require 'date'

class Student
  @@students = []

  attr_reader :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    begin
      @date_of_birth = Date.parse(date_of_birth)
    rescue ArgumentError
      raise ArgumentError, "date of birth must be in YYYY-MM-DD format!" 
    end 

    if @date_of_birth >= Date.today
      raise ArgumentError, "date of birth must be in the past!" 
    end

    @surname = surname
    @name = name

    
    if duplicate? 
      raise ArgumentError, "Duplicate student found in collection!"
    else
      add_student
    end
  end

  def duplicate?
    @@students.any? do |student|
      student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth     
    end
  end

  def calculate_age 
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if Date.new(today.year, @date_of_birth.month, @date_of_birth.day) > today
    age
  end

  def add_student
    @@students << self
  end

  def self.remove_student(student)
    @@students.delete (student)
  end 

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.students
    @@students
  end
end