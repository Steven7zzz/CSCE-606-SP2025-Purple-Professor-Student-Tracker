class Student < ApplicationRecord
    validates :first_name, :last_name, :major, :email, presence: true
end
