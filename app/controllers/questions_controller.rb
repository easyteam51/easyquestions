class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.includes(:user).order(created_at: :desc)
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = current_user.questions.build(question_params)

      if @question.save
        redirect_to @question, success: t('defaults.flash_messages.created', item: Question.model_name.human)
      else
        flash.now[:danger] = t('defaults.flash_messages.not_created', item: Question.model_name.human)
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    if @question.update(question_params)
      redirect_to @question, success: t('defaults.flash_messages.updated', item: Question.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_messages.not_updated', item: Question.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path, danger: t('defaults.flash_messages.deleted', item: Question.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :body)
    end
end
