module Admin
  class AnswersController < ApplicationController
    before_action :require_login

    def destroy
      answer = Answer.find(params[:id])
      authorize [:admin, User]
      question = answer.question
      answer.destroy
      redirect_to question_path(question), notice: "Antwort gelöscht"
    end
  end
end
