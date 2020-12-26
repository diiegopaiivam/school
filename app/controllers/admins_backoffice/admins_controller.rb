class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [:edit]

  def index
    @admins = Admin.all
  end

  def edit

  end

  private 
    def set_admin
      @admin = Admin.find(params[:id])
    end 

end
