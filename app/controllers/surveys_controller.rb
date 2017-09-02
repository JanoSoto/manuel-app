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
    if current_user.student?
      @assigned_surveys = AssignedSurvey.select(:id, :name, :course_id, :answered, :evaluated_user_id, :survey_id, :user_id)
                                        .where(user_id: current_user.id)
    else
      @assigned_surveys = AssignedSurvey.joins(:course)
                                        .select(:id, :name, :course_id, :answered, :evaluated_user_id, :survey_id, :user_id)
                                        .where(courses: {user_id: current_user.id})
                                        .paginate(page: params[:page], per_page: 7)
                                        .order('assigned_surveys.created_at DESC')
    end
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
    @survey = AssignedSurvey.find_by(user_id: params[:user_id], 
                                     survey_id: params[:id], 
                                     course_id: params[:course_id],
                                     evaluated_user_id: params[:evaluated_user_id],
                                     name: params[:survey_name])
  end

  def results_by_user
    survey = AssignedSurvey.find(params[:survey_id])
    results = SurveyResult.select(:answer_option_id)
                          .where(assigned_survey_id: survey.id)
    labels = []
    data = []
    results.each_with_index do |result, index|
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
    respond_to do |format|
      format.html {render json: response.to_json }
    end
  end

  def results_by_group
    students = CourseStudent.where(group_name: params[:group_name], course_id: params[:course_id])
                            .pluck(:user_id)
    surveys = AssignedSurvey.where(course_id: params[:course_id],
                                    name: params[:survey_name],
                                    user_id: students,
                                    answered: true)
    labels = []
    datasets = []
    surveys.first.survey_results.each_with_index do |result, index|
      labels << 'Pregunta '+(index+1).to_s
    end
    colors = default_colors
    total_surveys = surveys.count

    #### CALCULAR EL RESULTADO PROMEDIO PARA CADA ESTUDIANTE
    #### Ya que ahora se está mostrando su resultado más de una vez (uno por cada encueseta)

    #Resultado promedio
    require 'matrix'

    average = Vector.elements(Array.new(labels.count, 0.0))
    students_average = Hash.new
    debug = []
    surveys.each_with_index do |survey, index|
      data = Vector.elements(survey.survey_results.map{|result| result.answer_option.score.to_f})
      if students_average[survey.evaluated_user_id].nil?
        students_average[survey.evaluated_user_id] = Hash.new
        students_average[survey.evaluated_user_id][:data] = data
        students_average[survey.evaluated_user_id][:count] = 1
        students_average[survey.evaluated_user_id][:student] = survey.evaluated_user.full_name
      else
        students_average[survey.evaluated_user_id][:data] += data
        students_average[survey.evaluated_user_id][:count] += 1
      end
      average += data
    end
    students_average.each_with_index do |student_average, index|
      datasets << {
        'label': student_average[1][:student],
        'data': student_average[1][:data] / student_average[1][:count],
        'backgroundColor': 'rgba(0,0,0,0)',#colors[index%colors.count][:background],
        'borderColor': colors[index%colors.count][:border],
        'pointBorderColor': '#FFF',
        'pointHoverBackgroundColor': '#FFF',
        'pointHoverBorderColor': colors[index%colors.count][:border],
        'pointStyle': colors[index%colors.count][:pointer]
      }
    end
    surveys_count = surveys.count
    datasets << {
                'label': 'Promedio del grupo',
                'data': average / surveys_count,
                'backgroundColor': colors[surveys_count%colors.count][:background],
                'borderColor': colors[surveys_count%colors.count][:border],
                'pointBorderColor': '#FFF',
                'pointHoverBackgroundColor': '#FFF',
                'pointHoverBorderColor': colors[surveys_count%colors.count][:border]
              }

    respond_to do |format|
      format.html {render json: {'labels': labels, 'datasets': datasets}.to_json }
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

    def default_colors
      return [
        {
          background: 'rgba(244, 67, 54, 0.5)',
          border: 'rgba(244, 67, 54, 1)',
          pointer: 'triangle'
        },
        {
          background: 'rgba(255, 152, 0, 0.5)',
          border: 'rgba(255, 152, 0, 1)',
          pointer: 'cross'
        },
        {
          background: 'rgba(41, 182, 246, 0.5)',
          border: 'rgba(41, 182, 246, 1)',
          pointer: 'star'
        },
        {
          background: 'rgba(156, 39, 176, 0.5)',
          border: 'rgba(156, 39, 176, 1)',
          pointer: 'rect'
        },
        {
          background: 'rgba(33, 150, 243, 0.5)',
          border: 'rgba(33, 150, 243, 1)',
          pointer: 'line'
        },
        {
          background: 'rgba(0, 137, 123, 0.5)',
          border: 'rgba(0, 137, 123, 1)',
          pointer: 'dash'
        },
        {
          background: 'rgba(139, 195, 74, 0.5)',
          border: 'rgba(139, 195, 74, 1)',
          pointer: 'rectRounded'
        },
        {
          background: 'rgba(205, 220, 57, 0.5)',
          border: 'rgba(205, 220, 57, 1)',
          pointer: 'rectRot'
        },
        {
          background: 'rgba(255, 64, 129, 0.5)',
          border: 'rgba(255, 64, 129, 1)',
          pointer: 'crossRot'
        },
        {
          background: 'rgba(255, 255, 0, 0.5)',
          border: 'rgba(255, 255, 0, 1)',
          pointer: 'circle'
        }
      ]
    end
end
