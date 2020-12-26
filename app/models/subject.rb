class Subject < ApplicationRecord
    # Setando quantidade de itens por página
    paginates_per 10
end
