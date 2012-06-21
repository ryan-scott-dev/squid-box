class RepositoryIsCloning < ActiveRecord::Migration
  def change
    add_column :repositories, :is_cloning, :boolean
  end
end
