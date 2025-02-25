# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Teacher.create([
  { first_name: "Alice", last_name: "Smith", uin: "12345678", department: "Computer Science", course_and_semester: "CSCE 606 - Fall 2025", description: "Expert in AI" },
  { first_name: "Bob", last_name: "Johnson", uin: "87654321", department: "Mathematics", course_and_semester: "MATH 101 - Spring 2025", description: "Specialist in Calculus" }
])
