class AnswerOptionsController < ApplicationController
  before_action :set_answer_option, only: [:show, :edit, :update, :destroy]

  # GET /answer_options
  # GET /answer_options.json
  def index
    @answer_options = AnswerOption.all
  end

  # GET /answer_options/1
  # GET /answer_options/1.json
  def show
  end

  # GET /answer_options/new
  def new
    @answer_option = AnswerOption.new
  end

  # GET /answer_options/1/edit
  def edit
  end

  # POST /answer_options
  # POST /answer_options.json
  def create
    @answer_option = AnswerOption.new(answer_option_params)

    respond_to do |format|
      if @answer_option.save
        format.html { redirect_to @answer_option, notice: 'Answer option was successfully created.' }
        format.json { render :show, status: :created, location: @answer_option }
      else
        format.html { render :new }
        format.json { render json: @answer_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer_options/1
  # PATCH/PUT /answer_options/1.json
  def update
    respond_to do |format|
      if @answer_option.update(answer_option_params)
        format.html { redirect_to edit_question_path(@answer_option.question)+'/'+@answer_option.question.survey.id.to_s, 
                      notice: 'Opción de respuesta actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @answer_option }
      else
        format.html { render :edit }
        format.json { render json: @answer_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_options/1
  # DELETE /answer_options/1.json
  def destroy
    begin
      @answer_option.destroy
      respond_to do |format|
        format.html { redirect_to edit_question_path(@answer_option.question)+'/'+@answer_option.question.survey.id.to_s, 
          notice: 'Opción de respuesta eliminada con éxito.' }
      end
    rescue Exception => e
      respond_to do |format|
        format.html { redirect_to edit_question_path(@answer_option.question)+'/'+@answer_option.question.survey.id.to_s, 
          alert: 'No es posible eliminar esta opción de respuesta ya que ha sido utilizada en una encuesta.' }
      end
    end
  end

  def add_answer_option_ajax
    respond_to do |format|
      format.html {render json: AnswerOption.create(answer: params[:answer], 
                                                    score: params[:score], 
                                                    question_id: params[:question_id]).to_json}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_option
      @answer_option = AnswerOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_option_params
      params.require(:answer_option).permit(:answer, :score, :question_id)
    end
end
