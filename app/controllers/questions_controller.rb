class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers || []
    @answers = @question.answers.includes(:user).order(created_at: :desc)
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = current_user.questions.find(params[:id])
  end

  # POST /questions or /questions.json
  def create
    @question = current_user.questions.build(question_params)

      if @question.save
        flash[:success] = '投稿に成功しました'
        redirect_to @question
      else
        flash.now[:danger] = '投稿に失敗しました'
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    @question = current_user.question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question, success: '編集に成功しました'
    else
      flash.now[:danger] = '編集に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path, notice: '質問を削除しました'
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
