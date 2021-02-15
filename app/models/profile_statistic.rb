class ProfileStatistic < ApplicationRecord
  belongs_to :profile

  # Atributo virtual de total de questões
  def total_questions
    self.right_question + self.wrong_question
  end

  # Metódo de classe para chamar no controller sem precisar instancia-lo
  def self.set_statistic(answer, current_profile)
    profile_statistic = ProfileStatistic.find_or_create_by(profile: current_profile)
    answer.correct? ? profile_statistic.right_question += 1 : profile_statistic.wrong_question += 1
    profile_statistic.save
  end
end
