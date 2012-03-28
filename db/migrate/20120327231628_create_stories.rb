class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.integer :pt_story_id
      t.integer :project_id
      t.integer :pt_project_id
      t.string :description
      t.integer :count

      t.timestamps
    end
  end
end
