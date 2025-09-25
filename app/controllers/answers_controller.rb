class AnswersController < ApplicationController
  before_action :require_login

  def create
    question = Question.find(params[:question_id])
    answer = question.answers.new(answer_params.merge(user: current_user))
    authorize answer
    if answer.save
      redirect_to question_path(question), notice: "Antwort erstellt"
    else
      redirect_to question_path(question), alert: answer.errors.full_messages.to_sentence
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end
