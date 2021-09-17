module UsersBackoffice::ProfileHelper
    def gender_select(user, current_render)
        user.user_profile.gender == current_render ? "btn-primary" : "btn-secondary"
    end
end
