class HrProcess < ActiveRecord::Base
	has_many :product_hr_processes
	has_many :products, through: :product_hr_processes

  def self.search(search, page)
      paginate per_page: 30, page: page, conditions: ['hr_process_tag LIKE ?', "%#{search}%"], order: 'id ASC'
  end

end
