module ConvertSemesterHelper
	
	def integrated_semester(old_semester)
    	hash_term = {"1" => "（秋季）第一学期", "2" => "（春季）第二学期", "3" => "（夏季）第三学期"}
    	year_term = old_semester.split(/-/)
    	year = year_term[0] + "-" + (year_term[0].to_i + 1).to_s + "学年"
    	term = hash_term[year_term[1]]
    	int_semester = year + term
  	end

end
