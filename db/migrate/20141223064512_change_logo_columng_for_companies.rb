class ChangeLogoColumngForCompanies < ActiveRecord::Migration
  def change
  	add_attachment :companies, :logo_image
  end
end
