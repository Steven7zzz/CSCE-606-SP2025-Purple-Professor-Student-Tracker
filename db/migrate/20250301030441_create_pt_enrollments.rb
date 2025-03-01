class CreatePtEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :pt_enrollments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :peer_teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
