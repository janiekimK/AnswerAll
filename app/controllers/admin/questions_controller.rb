module Admin
  class QuestionsController < ApplicationController
    before_action :require_login

    def destroy
      question = Question.find(params[:id])
      authorize [:admin, User]
      question.destroy
      redirect_to questions_path, notice: "Frage gelöscht"
    end
  end
end
