class ProfilesBackoffice::PerfilController < ProfilesBackofficeController
    before_action :set_user
    def edit
    end

    def update
        if @profile.update(user_params)
            redirect_to profiles__backoffice_profile_path, notice: "Usuário atualizado com sucesso!"
          else 
            render :edit
        end
    end

    private 
        def set_user
            @user = Profile.find(current_profile.id)
        end

        def user_params
            params.require(:profile).permit(:first_name, :last_name, :email)
        end
end
