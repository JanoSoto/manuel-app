class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :preview]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to surveys_url, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
  end

  def my_surveys
    @assigned_surveys = AssignedSurvey.select(:id, :name, :course_id, :answered, :evaluated_user_id, :survey_id)
                                      .where(user_id: current_user.id)
  end

  def my_pending_surveys
    @pending_surveys = AssignedSurvey.select(:id, :name, :course_id, :answered, :evaluated_user_id)
                                      .where(user_id: current_user.id, answered: false)
  end

  def answer_survey
    @assigned_survey = AssignedSurvey.find(params[:id])
  end

  def save_survey_answers
    params[:answers].to_a.each do |answer|
      SurveyResult.create(assigned_survey_id: params[:assigned_survey], answer_option_id: answer[1])
    end
    AssignedSurvey.find(params[:assigned_survey]).update(answered: true)
    respond_to do |format|
      format.html {redirect_to my_surveys_path, notice: 'Encuesta contestada con éxito'}
    end
  end

  def results
    @survey = AssignedSurvey.find_by(user_id: current_user.id, survey_id: params[:id])
  end

  def results_by_user
    survey = AssignedSurvey.find_by(user_id: current_user.id, survey_id: params[:survey_id])
    results = SurveyResult.select(:answer_option_id)
                          .where(assigned_survey_id: survey.id)
    labels = []
    data = []
    results.each_with_index do |result, index|
      # labels << result.answer_option.question.statement
      labels << 'Pregunta '+(index+1).to_s
      data << result.answer_option.score
    end
    response = {
      'labels': labels,
      'datasets': [
        {
          'label': survey.evaluated_user.full_name,
          'data': data,
          'backgroundColor': 'rgba(0, 167, 208, 0.5)',
          'borderColor': 'rgba(0, 167, 208, 1)',
          'pointBorderColor': '#FFF',
          'pointHoverBackgroundColor': '#FFF',
          'pointHoverBorderColor': 'rgba(0, 167, 208, 1)'
        }
      ]
    }
    puts response.to_json
    respond_to do |format|
      format.html {render json: response.to_json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :description)
    end
end
