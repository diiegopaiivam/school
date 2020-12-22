class AdminsBackofficeController < ApplicationController
    ##Protegendo páginas internas
    before_action :authenticate_admin!
    layout 'admin_backoffice'
end
