json.extract! course, :id, :name, :number, :section, :year, :semester, :created_at, :updated_at
json.url course_url(course, format: :json)
