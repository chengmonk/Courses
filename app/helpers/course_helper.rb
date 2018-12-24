module CourseHelper
	
	def integrated_semester(old_semester)

    hash_term = {"1" => "（秋季）第一学期", "2" => "（春季）第二学期", "3" => "（夏季）第三学期"}
    year_term = old_semester.split(/-/)
    year = year_term[0] + "-" + (year_term[0].to_i + 1).to_s + "学年"
    term = hash_term[year_term[1]]
    int_semester = year + term

  end

  def is_open_student?

  	@sys = Systeminfo.first
  	start_time = @sys.cs_start
  	end_time = @sys.cs_end
  	current_time = Time.now
  	current_time > start_time and current_time < end_time and !@sys.teacher
    true

  end

  def is_open_teacher?

  	@sys = Systeminfo.last
  	start_time = @sys.cs_start
  	end_time = @sys.cs_end
  	current_time = Time.now
  	current_time > start_time and current_time < end_time and @sys.teacher
    true

  end

  def is_over_number?(course)
    if course[:student_num] >= course[:limit_num]
      true
    else
      false
    end
  end


  def is_exit_course?(id)
    if current_user.courses.where(:semester => current_semester).find_by_id(id)
      true
    else
      false
    end
  end

  def is_time_conflict?(wanted_course)
    flag = false
    org_course_time = wanted_course.course_time
    org_course_week = wanted_course.course_week
    courses = current_user.courses.where(:semester => current_semester)
    day_week = org_course_time[0] + org_course_time[1]
    course_time = org_course_time.scan(/\d+/)
    course_week = org_course_week.scan(/\d+/)

    if !courses.where('course_time like :str', str: "%#{day_week}%")
      flag = false
    else
      courses.each do |course|
        temp_week = course.course_time[0] + course.course_time[1]
        if !interval_overlap(course_time, course.course_time.scan(/\d+/))
          flag = false
        elsif interval_overlap(course_week, course.course_week.scan(/\d+/)) and (temp_week == day_week)
          flag = true
          break
        else
          flag = false
        end
        temp_week = ""
      end
    end
    flag
  end

  def interval_overlap(interval1, interval2)
    if (interval1[0].to_i > interval2[1].to_i) or (interval2[0].to_i > interval1[1].to_i)
      false
    else
      true
    end
  end

  def current_semester
    Systeminfo.first.semester
  end

  def systeminfo_exit?

    if Systeminfo.all.count == 2
      true
    else
      false
    end
  end


end
