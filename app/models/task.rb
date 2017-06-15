class Task < ApplicationRecord
	# belongs_to :user
	belongs_to :task_template
	# belongs_to :task_group

	def siblings
		self.task_template.tasks.order("created_at")
	end

	def done?
		self.practice_time.present?
	end

	def practice_time_str
		if self.practice_time.present?
			humanize(self.practice_time/1000)
		end
	end

	def humanize(secs)
		[[60, "秒"], [60, "分"], [24, "小时"], [1000, "天"]].map{|count, name|
			if secs > 0
				secs, n = secs.divmod(count)
				"#{n.to_i} #{name}"
			end
		}.compact.reverse.join(' ')
	end

end
