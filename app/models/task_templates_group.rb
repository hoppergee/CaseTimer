class TaskTemplatesGroup < ApplicationRecord
	has_many :task_templates, :dependent => :destroy, inverse_of: :task_templates_group
	has_many :templates, foreign_key: "task_templates_group_id", class_name: "TaskTemplate"
	belongs_to :case
	belongs_to :user

	accepts_nested_attributes_for :task_templates, :allow_destroy => true, :reject_if => :all_blank

	def all_tasks
		tasks = []
		self.templates.each do |template|
			tasks << template.tasks
		end
		tasks.flatten
	end

	def round_group_tasks
		group_tasks = []
		all_tasks = self.all_tasks
		last = all_tasks.sort_by{|t| t.created_at }.last
		if last 
			round = last.round
			round.times do |i|
				group_tasks << all_tasks.select{ |t| t.round == i }
			end
		end
		group_tasks
	end
end
