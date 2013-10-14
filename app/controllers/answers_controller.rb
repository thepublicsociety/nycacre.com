class AnswersController < ApplicationController
  load_and_authorize_resource
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(params[:answer])
    if @answer.save
      redirect_to questions_path
    else
      redirect_to question_path(@question)
    end
  end
end
