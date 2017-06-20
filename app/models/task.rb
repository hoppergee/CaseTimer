class Task < ApplicationRecord
	after_update_commit { TaskBroadcastJob.perform_later self}
	# belongs_to :user
	belongs_to :task_template
	# belongs_to :task_group

	def siblings
		tasks = []
		# self.task_template.tasks.where(round: self.round).order("created_at")
		self.task_template.group.task_templates.each do |template|
			task = template.tasks.find_by(round: self.round)
			tasks << task
		end
		tasks.sort_by { |t| t.created_at }
	end

	def done?
		self.practice_time.present?
	end

	def practice_time_str
		if self.practice_time.present?
			humanize(self.practice_time/1000)
		end
	end

	def user
		self.task_template.group.user
	end



end
