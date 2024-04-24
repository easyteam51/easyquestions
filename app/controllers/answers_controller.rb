class AnswersController < ApplicationController
  def new
    @answer = @question.answers.build
  end

  def create
    answer = current_user.answers.build(answer_params)
    if  answer.save
      flash[:success] = '投稿に成功しました'
      redirect_to question_path(answer.question), success: t('defaults.flash_messages.created', item: Answer.model_name.human)
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_to question_path(answer.question), danger: t('defaults.flash_messages.not_created', item: Answer.model_name.human)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:content).merge(question_id: params[:question_id])
  end
end
