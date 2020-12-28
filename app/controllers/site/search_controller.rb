class Site::SearchController < SiteController
    def questions
        @questions = Question.search_question(params[:page], params[:term])
    end
end
