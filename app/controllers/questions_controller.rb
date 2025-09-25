class QuestionsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: [:index, :show]
  after_action :verify_policy_scoped, only: :index

  def index
    @q = params[:q].to_s.strip
    scope = policy_scope(Question.includes(:user).order(created_at: :desc))
    @questions = @q.present? ? scope.where("title LIKE ? OR description LIKE ?", "%#{@q}%", "%#{@q}%") : scope
  end

  def show
  end

  def new
    @question = current_user.questions.new
    authorize @question
  end

  def create
    @question = current_user.questions.new(question_params)
    authorize @question
    if @question.save
      redirect_to @question, notice: "Frage erstellt"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @question
  end

  def update
    authorize @question
    if @question.update(question_params)
      redirect_to @question, notice: "Frage aktualisiert"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to questions_path, notice: "Frage gelöscht"
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
