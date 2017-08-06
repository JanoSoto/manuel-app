class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :assign_students]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @students = CourseStudent.where(course_id: @course.id).pluck(:user_id, :role).map{|student| {name: User.find(student[0]).full_name, role: student[1]} }
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
    @assigned_students = CourseStudent.where(course_id: @course.id).pluck(:user_id, :role).map{|student| {id: student[0], email: User.find(student[0]).email, role: student[1]} }
  end

  def assign_student_to_course
    respond_to do |format|
      format.html {render json: CourseStudent.create(course_id: params[:course_id], user_id: params[:student_id], role: params[:role])}
    end
  end

  def remove_student_from_course
    respond_to do |format|
      format.html {render json: CourseStudent.find_by(course_id: params[:course_id], user_id: params[:student_id]).destroy}
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
