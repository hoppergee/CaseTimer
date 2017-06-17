class TaskGroup < ApplicationRecord
	belongs_to :user
	belongs_to :case
	has_many :tasks
	has_many :grades

	def templates_group
		self.tasks.first.task_template.group
	end
end
