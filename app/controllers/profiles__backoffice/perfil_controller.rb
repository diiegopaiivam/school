class ProfilesBackoffice::PerfilController < ProfilesBackofficeController
    before_action :set_user
    def edit
    end

    private 
        def set_user
            @user = Profile.find(current_profile.id)
        end
end
