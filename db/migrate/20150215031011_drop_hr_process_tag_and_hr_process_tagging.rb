class DropHrProcessTagAndHrProcessTagging < ActiveRecord::Migration
  def change
  	drop_table :hr_process_tags
  	drop_table :hr_process_taggings
  end
end
