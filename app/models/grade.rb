class Grade < ApplicationRecord
	belongs_to :user
	belongs_to :case
	belongs_to :task_templates_group

	alias_attribute :group, :task_templates_group

	def round_time_str
		humanize(self.round_time/1000)
	end

end
