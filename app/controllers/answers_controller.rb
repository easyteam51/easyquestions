class AnswersController < ApplicationController
  def create
    answer = current_user.answers.build(answer_params)
    # binding.pry
    if  answer.save
      redirect_to question_path(answer.question), success: t('defaults.flash_messages.created', item: Answer.model_name.human)
    else
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
    params.require(:answer).permit(:content, :user_id).merge(question_id: params[:question_id])
  end
end
