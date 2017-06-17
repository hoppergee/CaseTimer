class TaskTemplate < ApplicationRecord
	has_many :tasks
	belongs_to :task_templates_group


	# belongs_to :group, class_name: "TaskTemplatesGroup", foreign_key: "id"
	alias_attribute :group, :task_templates_group
end
