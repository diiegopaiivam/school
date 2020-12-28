class Site::AnswerController < SiteController
    def questions
        @answer = Answer.find(params[:answer_id])
    end
end
