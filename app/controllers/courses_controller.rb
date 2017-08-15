class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :assign_students, :assign_survey]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @students = CourseStudent.where(course_id: @course.id).pluck(:user_id, :role, :group_name).map{|student| {name: User.find(student[0]).full_name, role: student[1], group_name: student[2]} }
    @color = ["info", "warning", "danger", "gray", "navy", "purple", "orange", "maroon"]
    surveys = AssignedSurvey.select(:id, :name, :survey_id).where(course_id: params[:id]).group(:name)
    @assigned_surveys = []
    surveys.each do |survey|
      answered = AssignedSurvey.where(answered: true, name: survey.name).count
      pending = AssignedSurvey.where(answered: false, name: survey.name).count
      @assigned_surveys << {id: survey.id,
                            name: survey.name, 
                            template: survey.survey.name, 
                            percentage: (answered.to_f/(answered + pending).to_f)*100}
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
    students = CourseStudent.select(:user_id).where(course_id: params[:course_id]).where.not(role: 'Ayudante')
    students.each do |student|
      AssignedSurvey.create(
                    survey_id: params[:survey_id],
                    user_id: student.user_id,
                    course_id: params[:course_id],
                    name: params[:name],
                    answered: false)
    end
    respond_to do |format|
      format.html {redirect_to course_path(params[:course_id]), notice: 'Encuesta asignada con éxito'}
    end
  end

  def assigned_survey_details
    @course = Course.find(params[:course_id])
    @assigned_survey = AssignedSurvey.select(:answered, :user_id, ).where(course_id: params[:course_id], name: params[:survey_name])
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
