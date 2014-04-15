module SessionsHelper
    def sign_in(user)
        remember_token = User.new_remember_token
        cookies.permanent[:remember_token] = remember_token
        user.update_attribute(:remember_token, User.encrypt(remember_token))
        self.current_user = user
    end

    def current_user=(user)
        @current_user = user
    end

    def current_user
        remember_token = User.encrypt(cookies[:remember_token])
        @current_user ||= User.find_by(remember_token: remember_token)
    end

    def current_user?(user)
        user == current_user
    end

    def signed_in?
        !current_user.nil?
    end

    def admin?
        current_user.role_id==2
    end

    def sign_out
        current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
        cookies.delete(:remember_token)
        self.current_user = nil
    end

    def scrummaster?
        ap = current_user.activeproject_id
        if  ap != nil
            return current_user.id == Project.find(ap).scrummaster_id
        end
        false
    end

    def productowner?
        current_user.activeproject.productowner==current_user
    end

    def sprint_running?(sprint)
        now = Date.today

        sprint.start <= now && sprint.end >= now
    end

    def sprint_past?(sprint)
        now = Date.today

        sprint.end < now
    end

    def activeproject?
        current_user.activeproject!=nil
    end
end
