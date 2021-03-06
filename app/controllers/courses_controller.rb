class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :assign_students, :assign_survey]

  # GET /courses
  # GET /courses.json
  def index
    if current_user.admin?
      @courses = Course.paginate(page: params[:page], per_page: 30).order('created_at DESC')
    elsif current_user.teacher?
      @courses = Course.where(user_id: current_user.id)
                       .paginate(page: params[:page], per_page: 30)
                       .order('created_at DESC')
    else
      @courses = Course.joins(:course_students)
                       .where('course_students.user_id' => current_user.id)
                       .paginate(page: params[:page], per_page: 30)
                       .order('created_at DESC')
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @students = CourseStudent.where(course_id: @course.id).pluck(:user_id, :role, :group_name).map{|student| {name: User.find(student[0]).full_name, role: student[1], group_name: student[2]} }
    @color = ["info", "danger", "gray", "navy", "purple", "orange", "maroon"]
    surveys = AssignedSurvey.select(:name, :survey_id)
                            .where(course_id: params[:id])
                            .group(:name, :survey_id)
    @assigned_surveys = []
    unless current_user.student? and not current_user.project_leader?(@course.id)
      surveys.each do |survey|
        answered = AssignedSurvey.where(answered: true, name: survey.name).count
        pending = AssignedSurvey.where(answered: false, name: survey.name).count
        @assigned_surveys << {#id: survey[:survey_id], #survey.id,
                              name: survey.name, 
                              template: survey.survey.name, 
                              percentage: (answered.to_f/(answered + pending).to_f)*100}
      end
    else
      @assigned_surveys = AssignedSurvey.select(:id, :name, :course_id, :answered, :evaluated_user_id, :survey_id)
                                        .where(user_id: current_user.id, course_id: @course.id)

    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_url, notice: 'Curso creado satisfactoriamente' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Curso editado satisfactoriamente' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.update(status: !@course.status)
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Curso '+(@course.status ? 'activado' : 'desactivado')+' satisfactoriamente' }
      format.json { head :no_content }
    end
  end

  def assign_students
    @assigned_students = CourseStudent.where(course_id: @course.id).pluck(:user_id).map{|student| User.find(student) }
    @unassigned_students = User.where(roles_id: 3) - @assigned_students
    @groups = CourseStudent.where(course_id: @course.id).where.not(group_name: nil).pluck(:user_id, :role, :group_name).map{|student| {id: student[0], email: User.find(student[0]).email, role: student[1], group_name: student[2]} }.group_by{|group| group[:group_name] }.sort
    @assigned_students = CourseStudent.where(course_id: @course.id, group_name: nil).pluck(:user_id, :role, :group_name).map{|student| {id: student[0], email: User.find(student[0]).email, role: student[1], group_name: student[2]} }.group_by{|group| group[:group_name] }
  end

  def assign_student_to_course    
    assign = CourseStudent.find_by(course_id: params[:course_id], user_id: params[:student_id])
    respond_to do |format|
      if assign.nil?
        format.html {render json: CourseStudent.create(course_id: params[:course_id], 
                                                       user_id: params[:student_id], 
                                                       role: params[:role], 
                                                       group_name: params[:group_name])}
      else
        format.html{render json: assign.update(role: params[:role], group_name: params[:group_name])}
      end
    end
  end

  def remove_student_from_course
    respond_to do |format|
      format.html {render json: CourseStudent.find_by(course_id: params[:course_id], user_id: params[:student_id]).destroy}
    end
  end

  def assign_survey
    @surveys = Survey.all.map{|survey| [survey.name, survey.id]}
  end

  def save_assigned_survey
    groups = CourseStudent.select(:user_id, :group_name)
                           .where(course_id: params[:course_id])
                           .where.not(group_name: nil)
                           .group_by{|student| student.group_name }
                           .sort
                           .to_h
    students = CourseStudent.select(:user_id, :group_name).where(course_id: params[:course_id]).where.not(role: 'Ayudante')
    students.each do |student|
      unless student.group_name.nil?
        groups[student.group_name].each do |evaluate_user|
          AssignedSurvey.create(
                        survey_id: params[:survey_id],
                        user_id: student.user_id,
                        evaluated_user_id: evaluate_user.user_id,
                        course_id: params[:course_id],
                        name: params[:name],
                        answered: false)
        end
      end
    end
    respond_to do |format|
      format.html {redirect_to course_path(params[:course_id]), notice: 'Encuesta asignada con éxito'}
    end
  end

  def assigned_survey_details
    @course = Course.find(params[:course_id])
    surveys = AssignedSurvey.select(:answered, :user_id, :evaluated_user_id, :survey_id)
                                     .where(course_id: params[:course_id], name: params[:survey_name])
    @assigned_survey = []
    surveys.each do |survey|
      @assigned_survey << {student: survey.user.full_name,
                           evaluated: survey.evaluated_user.nil? ? '' : survey.evaluated_user.full_name, 
                           answered: survey.answered, 
                           group: CourseStudent.find_by(course_id: @course.id, user_id: survey.user_id).group_name,
                           survey_id: survey.survey_id,
                           evaluated_user_id: survey.evaluated_user_id
                         }
    end
    groups = @assigned_survey.group_by{|survey| survey[:group]}.to_a
    @assigned_survey = @assigned_survey.paginate(page: params[:page], per_page: 5)
    @groups_percentage = []
    groups.each do |group|
      answered = 0
      pending = 0
      group[1].each do |student|
        if student[:answered]
          answered += 1
        else
          pending += 1
        end
      end
      @groups_percentage << {name: group[0], percentage: (answered.to_f/(answered+pending).to_f)*100}
    end

    ##Cálculo de los módulos resultados por estudiante
    require 'matrix'
    surveys = AssignedSurvey.where(name: params[:survey_name], course_id: params[:course_id], answered: true)
    students_average = Hash.new
    module_results = Hash.new
    average = Hash.new

    surveys.each_with_index do |survey, index|
      data = Vector.elements(survey.survey_results.map{|result| result.answer_option.score.to_f})
      if students_average[survey.evaluated_user_id].nil?
        students_average[survey.evaluated_user_id] = Hash.new
        students_average[survey.evaluated_user_id][:data] = data
        students_average[survey.evaluated_user_id][:count] = 1
        students_average[survey.evaluated_user_id][:group] = CourseStudent.find_by(course_id: @course.id, 
                                                                                   user_id: survey.user_id)
                                                                          .group_name
        students_average[survey.evaluated_user_id][:module] = 0
        students_average[survey.evaluated_user_id][:student] = survey.evaluated_user.full_name
      else
        students_average[survey.evaluated_user_id][:data] += data
        students_average[survey.evaluated_user_id][:count] += 1
      end

      if average[students_average[survey.evaluated_user_id][:group]].nil?
        average[students_average[survey.evaluated_user_id][:group]] = Hash.new
        average[students_average[survey.evaluated_user_id][:group]][:sum] = data
        average[students_average[survey.evaluated_user_id][:group]][:count] = 1
      else
        average[students_average[survey.evaluated_user_id][:group]][:sum] += data
        average[students_average[survey.evaluated_user_id][:group]][:count] += 1
      end
    end

    @group_result = Hash.new
    students_average.each do |student|
      student[1][:data].each_with_index do |a, i|
        student[1][:module] += a/student[1][:count] - average[student[1][:group]][:sum][i]/average[student[1][:group]][:count]
      end
      student[1][:module] /= student[1][:data].size

      group_name = CourseStudent.find_by(course_id: params[:course_id], user_id: student[0]).group_name
      if @group_result[group_name].nil?
        @group_result[group_name] = []
        @group_result[group_name] << {student: student[1][:student], result: student[1][:module]}
      else
        @group_result[group_name] << {student: student[1][:student], result: student[1][:module]}
      end
    end
  end

  def edit_assigned_survey
    @course = Course.find(params[:course_id])
    @assigned_survey = AssignedSurvey.find(params[:survey_id])
    @surveys = Survey.all.map{|survey| [survey.name, survey.id]}
  end

  def update_assigned_survey
    old_surveys = AssignedSurvey.where(name: params[:old_name])
    old_surveys.each do |old_survey|
      old_survey.update(name: params[:name], survey_id: params[:survey_id])
    end
    respond_to do |format|
      format.html {redirect_to course_path(params[:course_id]), notice: 'Encuesta editada con éxito'}
    end
  end

  def survey_results_by_group
    @course = Course.find(params[:course_id])
    @survey = AssignedSurvey.find_by(course_id: params[:course_id],
                                     name: params[:survey_name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :semester, :year, :status, :user_id)
    end
end
