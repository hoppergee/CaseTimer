class Article < ApplicationRecord

	CATEGORIES = ["tech", "edition"]
	validates_inclusion_of :category, :in => CATEGORIES
end
