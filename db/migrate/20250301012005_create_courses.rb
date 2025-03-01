class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :number
      t.string :section
      t.string :year
      t.string :semester

      t.timestamps
    end
  end
end
