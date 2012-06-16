class AddLocalPathToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :local_path, :string
    add_column :repositories, :has_local_clone, :boolean
  end
end
