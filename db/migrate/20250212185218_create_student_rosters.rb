class CreateStudentRosters < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:student_rosters)
      create_table :student_rosters do |t|
        t.string :name
        t.string :uin
        t.string :major
        t.string :class_level
        t.string :email
        t.integer :final

        t.timestamps
      end
    end
  end
end
