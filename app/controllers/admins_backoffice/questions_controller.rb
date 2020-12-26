class AdminsBackoffice::QuestionsController < AdminsBackofficeController
    before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all.page(params[:page])
  end

  def new 
    @question = Question.new
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Pergunta Salva com sucesso"
    else 
      render :new
    end
  end 

  def edit
  end

  def update
    if @question.update(questions_params)
      redirect_to admins_backoffice_questions_path, notice: "Pergunta Atualizado com sucesso"
    else 
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Pergunta Excluído com sucesso"
    else 
      render :index 
    end
  end

  private 
    def set_question
      @question = Question.find(params[:id])
    end 

    def questions_params
      params.require(:question).permit(:description, :subject_id)
    end 

end
