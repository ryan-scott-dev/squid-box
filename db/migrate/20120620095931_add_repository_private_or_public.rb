class AddRepositoryPrivateOrPublic < ActiveRecord::Migration
  def change
    add_column :repositories, :private, :boolean
  end
end
