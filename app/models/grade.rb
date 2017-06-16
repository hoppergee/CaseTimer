class Grade < ApplicationRecord
	belongs_to :user
	belongs_to :case

	def round_time_str
		humanize(self.round_time/1000)
	end

end
