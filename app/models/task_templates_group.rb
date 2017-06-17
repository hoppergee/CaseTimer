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
		unless all_tasks.empty?
			rounds = self.templates.first.tasks.map{|t| t.round}
			rounds.each do |round|
				group_tasks << all_tasks.select{|t| t.round == round}
			end
		end
		group_tasks
	end
end
