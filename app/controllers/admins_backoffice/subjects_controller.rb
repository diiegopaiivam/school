class AdminsBackoffice::SubjectsController < AdminsBackofficeController
    before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all.page(params[:page])
  end

  def new 
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subjects_params)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Salvo com sucesso"
    else 
      render :new
    end
  end 

  def edit
  end

  def update
    if @subject.update(subjects_params)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Atualizado com sucesso"
    else 
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Excluído com sucesso"
    else 
      render :index 
    end
  end

  private 
    def set_subject
      @subject = Subject.find(params[:id])
    end 

    def subjects_params
      params.require(:subject).permit(:description)
    end 

end
