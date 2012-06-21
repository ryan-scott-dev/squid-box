class AddRepositoryPrivateAndPublicKey < ActiveRecord::Migration
  def change
    add_column :repositories, :public_key, :text
    add_column :repositories, :private_key, :text
  end
end
