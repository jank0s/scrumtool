class User < ActiveRecord::Base
    belongs_to :role
    before_create :create_remember_token

    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, presence: true, length: {minimum: 3}, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
    validates :role_id, presence: true
    validates :password, length: {minimum: 3}, :if => :validate_password?
    validates :password_confirmation, presence: true, :if => :validate_password?

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    def validate_password?
        password.present? || password_confirmation.present?
    end

    def self.search(search)
        if search
            find(:all, :conditions => ['username LIKE ? OR name LIKE ? OR surname LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
        else
            find(:all)
        end
    end

    private
    def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token)
    end

end
