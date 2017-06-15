class TaskTemplatesGroup < ApplicationRecord
	has_many :task_templates
	has_many :templates, foreign_key: "task_templates_group_id", class_name: "TaskTemplate"
	belongs_to :case
	belongs_to :user

	# alias_attribute :templates, :task_templates
	# alias_attribute :target, :target_round
end
