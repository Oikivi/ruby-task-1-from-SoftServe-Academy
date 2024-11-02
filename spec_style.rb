require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../hw/student'

Minitest::Reporters.use! [
  Minitest::Reporters::JUnitReporter.new, 
  Minitest::Reporters::HtmlReporter.new(
  reports_dir: '../hw/spec_reports',
    reports_filename: 'students_spec_tests.html', 
    clean:false, 
    add_timestamp: true
  ) 
]

describe Student do
  before do
    Student.class_variable_set(:@@students, [])
    @student1 = Student.new('Moby', 'Awan', '2000-01-01')
    @student2 = Student.new('Smith', 'Nick', '2001-06-12')
    @student3 = Student.new('Cheese', 'Charly', '1999-05-10')
    @student4 = Student.new('Applewhite', 'Appli', '1998-12-31')
  end

  describe 'initialization' do
    it 'create student' do  
      student = Student.new('Selan', 'Nick', '2000-01-01')
      expect(student.name).must_equal 'Nick'
      expect(student.surname).must_equal 'Selan'
      expect(student.date_of_birth).must_equal Date.parse('2000-01-01') 
    end
  end
  describe 'initialization with wrong data format' do
    it 'create student with wrong birthDate format' do
      expect(proc { Student.new('Cheese', 'Charly', 'birthDate') }).must_raise ArgumentError
    end
  end

  describe 'initialization with future data' do
    it 'create student with future birthDate' do
      expect(proc { Student.new('Cheese', 'Charly', '2042-06-21') }).must_raise ArgumentError
    end
  end
  
  describe 'duplicate method' do
    it 'create student duplicate' do 
      expect(proc {Student.new('Cheese', 'Charly', '1999-05-10')}).must_raise ArgumentError
    end
  end

  describe 'remove method' do
    it 'remove student from array' do
      Student.remove_student(@student1)
      expect(Student.students.size).must_equal 3
    end
  end

  describe 'get students by age method' do
    it 'get students with selected age' do 
      age = 24 
      students_by_age = Student.get_students_by_age(age)
      expect(students_by_age.size).must_equal 1
    end
  end

  describe 'get students by age method' do
    it 'get students with selected age' do 
      students_by_name = Student.get_students_by_name('Nick')
      expect(students_by_name.size).must_equal 1
    end
  end
end