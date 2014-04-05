class Project < ActiveRecord::Base
	belongs_to :scrummaster, :class_name => 'User'
	belongs_to :productowner, :class_name => 'User'
	has_many :teammembers, :dependent => :destroy
    has_many :activeproject_users, :class_name => "User", :foreign_key => "activeproject_id"
	has_many :users, through: :teammembers
  has_many :sprints
    validates :name, presence: true, length: {minimum: 2, maximum: 255}, uniqueness: true
    validates :description, presence: true, length: {minimum: 2}
    validates :teammembers, presence: true
    validate :productowner_cannot_be_scrummaster
    
    def self.search(search)
        if search
            find(:all, :conditions => ['name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
        else
            find(:all)
        end
    end

    def productowner_cannot_be_scrummaster
        errors.add(:productowner, "cannot be same as scrummaster") unless 
            productowner != scrummaster or productowner.nil? or scrummaster.nil?
    end
    
  
end
