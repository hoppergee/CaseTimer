module CasesHelper

	def round_of(grades)
		if grades.size != 0
			round = grades.sort_by{|g| g.created_at}.last.round
			"#{round} 次"
		else
			"暂无"
		end
	end

	def average_time_of(grades)
		times = grades.map { |g| g.round_time }
		if times.size != 0
			time = times.sum / times.size
			humanize(time/1000)
		else
			"暂无"
		end
	end

	def fastest_time_of(grades)
		times = grades.map { |g| g.round_time }
		if times.size != 0
			humanize(times.min/1000)
		else
			"暂无"
		end
	end

	def total_time_of(grades)
		times = grades.map { |g| g.round_time }
		if times.size != 0
			humanize(times.sum/1000)
		else
			"暂无"
		end
	end

end
