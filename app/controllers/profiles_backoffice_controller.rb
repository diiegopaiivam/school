class ProfilesBackofficeController < ApplicationController
    ##Protegendo páginas internas
    before_action :authenticate_profile!
    layout 'profile_backoffice'
end
