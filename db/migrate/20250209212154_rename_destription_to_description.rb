class RenameDestriptionToDescription < ActiveRecord::Migration[8.0]
  def change
    rename_column :teachers, :destription, :description
  end
end
