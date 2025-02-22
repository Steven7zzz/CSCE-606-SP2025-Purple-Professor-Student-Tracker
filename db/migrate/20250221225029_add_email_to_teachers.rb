class AddEmailToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :email, :string
  end
end
