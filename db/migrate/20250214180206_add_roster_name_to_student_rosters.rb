class AddRosterNameToStudentRosters < ActiveRecord::Migration[8.0]
  def change
    add_column :student_rosters, :roster_name, :string
  end
end
