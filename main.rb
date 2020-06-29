require 'csv'
class Employee
  def read_file(file)
    CSV.read(file)
  end

  def extract_details(data)
    body = data.to_a[1..-1]
    body.sort_by { |row| row[2] }
   grouped_details = body.group_by { |row| row[2] }
   grouped_details.each do |key, value|
     value.sort_by { |row| row[1] }
   end
 end

 def sort_details(details)
    File.open("../employee.txt", "w") do |file|
      details.each do |designation, value|
        file.puts "#{designation}#{"s" if details[designation].length > 1}"
        value.each { |detail| file.puts "#{detail[0]} (EmpId: #{detail[1]})" }
        file.puts
      end
    end
  end
end
employee = Employee.new
data = employee.read_file("../input.csv")
details = employee.extract_details(data)
puts employee.sort_details(details)
