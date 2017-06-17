class Favor < ApplicationRecord
	belongs_to :user
	belongs_to :case
	belongs_to :task_templates_group

	belongs_to :group, class_name: "TaskTemplatesGroup", foreign_key: "task_templates_group_id"
end
