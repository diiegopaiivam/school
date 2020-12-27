class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  # Setando quantidade de itens por página
  paginates_per 10
end
