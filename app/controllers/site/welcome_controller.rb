class Site::WelcomeController < SiteController
  def index
    @questions = Question.lastQuestions(params[:page])
  end
end
