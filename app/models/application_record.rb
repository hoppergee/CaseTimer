class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  	def humanize(secs)
  		if secs == 0
			"0秒"
		else
			[[60, "秒"], [60, "分"], [24, "小时"], [1000, "天"]].map{|count, name|
				if secs > 0
					secs, n = secs.divmod(count)
					"#{n.to_i} #{name}"
				end
			}.compact.reverse.join(' ')
		end
	end
end
