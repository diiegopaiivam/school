class ProfilesBackoffice::PerfilController < ProfilesBackofficeController
    before_action :verify_password, only: [:update]
    before_action :set_profile
    def edit
    end

    def update
        if @profile.update(profile_params)
            sign_in(@profile, bypass: true) #Fazer o login novamente assim que atualizar o usuário
            redirect_to profiles__backoffice_profile_path, notice: "Usuário atualizado com sucesso!"
          else 
            render :edit
        end
    end

    private 
        def set_profile
            @profile = Profile.find(current_profile.id)
        end

        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        end

        ## Extraindo password e password confirmation, caso o usuário queira mudar apenas o email
        def verify_password
            if params[:profile][:password].blank? && params[:profile][:password_confirmation].blank? 
                params[:profile].extract!(:password, :password_confirmation)
            end
        end
end
