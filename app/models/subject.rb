class Subject < ApplicationRecord
    has_many :questions
    # Setando quantidade de itens por página
    paginates_per 10
end
