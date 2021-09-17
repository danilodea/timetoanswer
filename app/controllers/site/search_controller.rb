class Site::SearchController < SiteController
    def questions
        # params[:term]
        # @questions = Question.includes(:answers)
        #                      .page(params[:page])
        @questions = Question._search_(params[:page], params[:term])
    end

    def subject
        @questions = Question._search_subject_(params[:page], params[:subject_id])
    end
end
