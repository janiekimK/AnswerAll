class VotesController < ApplicationController
  before_action :require_login

  def create
    @question = Question.find(params[:id])
    answer = @question.answers.find(params[:answer_id])
    vote = answer.votes.find_or_initialize_by(user: current_user)
    vote.value = 1
    authorize vote
    if vote.save
      redirect_to question_path(@question), notice: "Vote gespeichert"
    else
      redirect_to question_path(@question), alert: vote.errors.full_messages.to_sentence
    end
  end

  def destroy
    @question = Question.find(params[:id])
    answer = @question.answers.find(params[:answer_id])
    vote = answer.votes.find_by(user: current_user)
    authorize vote || Vote
    vote&.destroy
    redirect_to question_path(@question), notice: "Vote entfernt"
  end
end
