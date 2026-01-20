class AddClicksToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :clicks_count, :integer, default: 0
    add_column :users, :cv_clicks_count, :integer, default: 0
  end
end
