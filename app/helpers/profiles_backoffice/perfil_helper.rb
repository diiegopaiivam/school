module ProfilesBackoffice::PerfilHelper
    def gender_select(user, current_gender)
        user.profile_user.gender == current_gender ? 'btn-primary' : 'btn-default'
    end
end
