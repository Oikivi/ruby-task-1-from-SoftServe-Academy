require 'minitest/autorun'
require 'minitest/reporters'
require '../hw/student'

Minitest::Reporters.use! [ 
  Minitest::Reporters::HtmlReporter.new(
  reports_dir: '../hw/unit_reports', 
    report_filename: 'students_unit_tests.html', 
    clean:false, 
    add_timestamp: true
  ) 
]

class StudentTestUnitStyle < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, []) 
    @student1 = Student.new('Moby', 'Awan', '2000-01-01')
    @student2 = Student.new('Smith', 'Nick', '2001-06-12')
    @student3 = Student.new('Cheese', 'Charly', '1999-05-10')
    @student4 = Student.new('Applewhite', 'Appli', '1998-12-31')
  end

  def test_initialize_student
    assert_equal 'Awan', @student1.name
    assert_equal 'Moby', @student1.surname
    assert_equal Date.parse('2000-01-01'), @student1.date_of_birth
  end

  def test_initialize_wrong_data_format
    assert_raises(ArgumentError) {Student.new('Cheese', 'Charly', 'birthDate')}  
  end 

  def test_initialize_future_data
    assert_raises(ArgumentError) {Student.new('Cheese', 'Charly', '2042-06-21')} 
  end 

  def test_initialize_student_duplicate
    assert_raises(ArgumentError) do
      begin
        Student.new('Cheese', 'Charly', '2042-06-21')
      end
    end
  end 

  def test_remove_student
    Student.remove_student(@student1)   
    assert_equal 3, Student.students.size
  end  

   def test_get_students_by_age
    age = 24
    students_by_age = Student.get_students_by_age(age)
    assert_equal 1, students_by_age.size
   end

   def test_get_students_by_name
    students_by_name = Student.get_students_by_name('Nick')
    assert_equal 1, students_by_name.size
   end
  
end 
