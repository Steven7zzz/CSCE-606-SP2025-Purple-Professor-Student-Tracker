class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :department
      t.string :course_and_semester
      t.text :destription

      t.timestamps
    end
  end
end
