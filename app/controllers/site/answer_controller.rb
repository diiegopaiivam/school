class Site::AnswerController < SiteController
    def questions
        @answer = Answer.find(params[:answer_id])
        ProfileStatistic.set_statistic(@answer, current_profile)
    end
end
