class Case < ApplicationRecord
	belongs_to :user
	has_many :grades
	has_many :task_groups
	has_many :task_templates_group
end
