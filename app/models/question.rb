class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  # Setando quantidade de itens por página
  paginates_per 10

  # Pesquisa as Questões utilizando como parâmetro o termo digitado e a página
  scope :search_question, -> (page, term){
    includes(:answers)
      .where("lower(description) LIKE ?", "%#{term}%")
      .page(page)
  }

  # Listar Perguntas por assuntos utilizando como parâmetros id do assunto e a página
  scope :search_subject, -> (page, subject_id){
    includes(:answers, :subject)
      .where(subject_id: subject_id)
      .page(page)
  }

  # Lista as últimas questões, utilizando como parâmetro a página
  scope :last_questions, -> (page){
    includes(:answers)
      .order('created_at desc')
      .page(page)
  }


end
