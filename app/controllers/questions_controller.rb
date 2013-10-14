class QuestionsController < ApplicationController
  load_and_authorize_resource
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(params[:question])
    if @question.save
      redirect_to questions_path
    else
      render :action => "new"
    end
  end
  
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.all
    @thequestion = Question.find(params[:id])
  end
  
  
  def acceptanswer
    @answer = Answer.find(params[:id])
    @option = params[:option]
    if @option == "accept"
      @answer.question.answers.each do |a|
        a.update_attribute("accepted", false)
      end
      @answer.update_attribute("accepted", true)
    else
      @answer.update_attribute("accepted", false)
    end
  end
end
