class ChangeUinToStringInStudents < ActiveRecord::Migration[8.0]
  def change
    change_column :students, :uin, :string
  end
end
