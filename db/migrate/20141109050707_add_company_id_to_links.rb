class AddCompanyIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :company_id, :integer
  end
end
