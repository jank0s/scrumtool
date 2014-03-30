class Project < ActiveRecord::Base
	belongs_to :scrummaster, :class_name => "User"
	belongs_to :productowner, :class_name => "User"
    validates :name, presence: true, length: {minimum: 3}, uniqueness: true
    validates :description, presence: true, length: {minimum: 3}
    validates :scrummaster_id, presence: true



    def self.search(search)
        if search
            find(:all, :conditions => ['name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
        else
            find(:all)
        end
    end

end
