class CompaniesTag < ActiveRecord::Base
	belongs_to :company, class_name: "Company"
	belongs_to :tag, class_name: "Tag"
	validates :company_id, presence: true
	validates :tag_id, presence: true
end
