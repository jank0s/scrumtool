class Project < ActiveRecord::Base

    validates :name, presence: true, length: {minimum: 3, maximum: 255}, uniqueness: true
    validates :description, presence: true, length: {minimum: 3}

end
