class AddUniqueIndexToPtEnrollments < ActiveRecord::Migration[8.0]
  def change
    # add a composite unique index
    add_index :pt_enrollments,
              [:course_id, :peer_teacher_id],
              unique: true,
              name: 'index_pt_enrollments_on_course_and_peer_teacher'
  end
end