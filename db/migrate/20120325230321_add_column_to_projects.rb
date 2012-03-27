class AddColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :pt_project_id, :integer
  end
end
