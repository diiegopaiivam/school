class ProfilesBackofficeController < ApplicationController
    ##Protegendo páginas internas
    before_action :authenticate_profile!
    layout 'profile_backoffice'
    before_action :build_profile

    def build_profile
        current_profile.build_profile_user if current_profile.profile_user.blank?
    end
end
