json.extract! student_roster, :id, :name, :uin, :major, :class_level, :email, :final, :created_at, :updated_at
json.url student_roster_url(student_roster, format: :json)
