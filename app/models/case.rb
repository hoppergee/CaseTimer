class Case < ApplicationRecord
	belongs_to :user
	has_many :grades
	has_many :task_groups
	has_many :task_templates_groups, :dependent => :destroy, inverse_of: :case
	has_many :favors

	mount_uploader :image, ImageUploader

	accepts_nested_attributes_for :task_templates_groups, allow_destroy: true, reject_if: :all_blank
end
