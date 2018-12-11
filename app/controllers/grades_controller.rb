class GradesController < ApplicationController

  before_action :teacher_logged_in, only: [:update]

  def update
    @grade = Grade.find_by_id(params[:id])
    if @grade.update_attributes!(:grade => params[:grade][:grade])
      flash = {:success => "#{@grade.user.name} #{@grade.course.name}的成绩已成功修改为 #{@grade.grade}"}
    else
      flash = {:danger => "上传失败.请重试"}
    end
    redirect_to :back, flash: flash
    # redirect_to grades_path(course_id: params[:course_id]), flash: flash
  end

  def index
    #binding.pry
    @semesters = Course.select(:semester).distinct.collect {|p| [integrated_semester(p.semester)]}
    if teacher_logged_in?
      @course = Course.find_by_id(params[:course_id])
      @grades = @course.grades.order(created_at: "desc").paginate(page: params[:page], per_page: 6)
    elsif student_logged_in?
      @grades = current_user.grades.paginate(page: params[:page], per_page: 6)
    else
      redirect_to root_path, flash: {:warning => "请先登陆"}
    end
  end


  private

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def integrated_semester(old_semester)
    hash_term = {"1" => "（秋季）第一学期", "2" => "（春季）第二学期", "3" => "（夏季）第三学期"}
    year_term = old_semester.split(/-/)
    year = year_term[0] + "-" + (year_term[0].to_i + 1).to_s + "学年"
    term = hash_term[year_term[1]]
    int_semester = year + term
  end


end
