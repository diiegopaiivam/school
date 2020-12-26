class Question < ApplicationRecord
  belongs_to :subject

  # Setando quantidade de itens por página
  paginates_per 10
end
