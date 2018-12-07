class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    redirect_to courses_path, flash: {:success => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    redirect_to courses_path, flash: {:success => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #-------------------------for students----------------------

  # def list
  #   #-------QiaoCode--------
  #   @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 4)
  #   @course = @courses-current_user.courses
  #   tmp=[]
  #   @course.each do |course|
  #     if course.open==true
  #       tmp<<course
  #     end
  #   end
  #   @course=tmp
  # end

  def list

    @op_courses_type = Course.select(:course_type).distinct.collect {|p| [p.course_type]}
    @op_times = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    @op_depts = Course.select(:department).distinct.collect {|p| [p.department]}
    @courses = Course.all.paginate(page: params[:page], per_page: 4)


    # modify query method

    if params[:department]
      @courses = @courses.where(:department => params[:department]).paginate(page: params[:page], per_page: 4)
    end

    if params[:type]
      @courses = @courses.where(:course_type => params[:type]).paginate(page: params[:page], per_page: 4)
    end
    
    if params[:time]
      @courses = @courses.where('course_time like :str', str: "%#{params[:time]}%").paginate(page: params[:page], per_page: 4)
    end

    if params[:name] != ""
      @courses = @courses.where('name like :str', str: "%#{params[:name]}%").paginate(page: params[:page], per_page: 4)
    end

    @remind_str = params[:department].to_s + params[:type].to_s + params[:time].to_s + params[:name].to_s
    
    tmp = []
    
    @courses.each do |course|
      if course.open == true
        tmp << course
      end
    end
    @course = tmp
  end


  def select

    # time error
    @select_course = Course.find_by_id(params[:id])
    @courses = current_user.courses
    @exit_course_id = @courses.find_by_id(params[:id])
    @exit_course_time = @courses.find_by_course_time(params[:course_time])
    if @select_course[:student_num] >= @select_course[:limit_num]
      flash = {:error => "Over numbers!: #{@select_course.name}"}
    elsif @exit_course_id
      flash = {:error => "Already selected!: #{@exit_course_id.name}"}
    elsif @exit_course_time#need to modify later
      flash = {:error => "Time conflict!: #{@exit_course_time.name}"}
    else
      current_user.courses << @select_course
      flash = {:suceess => "成功选择课程: #{@select_course.name}"}
    end
        
      
    # @course = Course.find_by_id(params[:id])
    # 
    redirect_to list_courses_path, flash: flash
  end

  # def select
  #   @course=Course.find_by_id(params[:id])
  #   current_user.courses<<@course
  #   flash={:suceess => "成功选择课程: #{@course.name}"}
  #   redirect_to courses_path, flash: flash
  # end

  def quit
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 4) if student_logged_in?
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week)
  end


end
