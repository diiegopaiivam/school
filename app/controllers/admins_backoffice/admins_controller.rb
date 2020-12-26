class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :verify_password, only: [:update]

  def index
    @admins = Admin.all.page(params[:page])
  end

  def new 
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admins_params)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador Salvo com sucesso"
    else 
      render :new
    end
  end 

  def edit
  end

  def update
    if @admin.update(admins_params)
      redirect_to admins_backoffice_admins_path, notice: "Administrador Atualizado com sucesso"
    else 
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador Excluído com sucesso"
    else 
      render :index 
    end
  end

  private 
    def set_admin
      @admin = Admin.find(params[:id])
    end 

    def admins_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end 

    ## Extraindo password e password confirmation, caso o usuário queira mudar apenas o email
    def verify_password
      if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank? 
        params[:admin].extract!(:password, :password_confirmation)
      end
    end


end
