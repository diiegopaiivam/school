class AdminStatistic < ApplicationRecord
    EVENTS = {
        total_users: "TOTAL_USERS",
        total_questions: "TOTAL_QUESTIONS"
    }

    #Scopes
    # Pesquisar a quantidade de questões cadastradas no sistema
    scope :total_questions, -> {
        find_by_event(EVENTS[:total_questions]).value
    }

    # Pesquisar o total de usuários
    scope :total_users, -> {
        find_by_event(EVENTS[:total_users]).value
    }

    # Método de classe para salvar eventos de administrador
    def self.set_event(event)
        admin_statistic = AdminStatistic.find_or_create_by(event: event)
        admin_statistic.value += 1
        admin_statistic.save
    end
end
