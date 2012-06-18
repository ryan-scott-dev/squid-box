class RenameUserPassword < ActiveRecord::Migration
  def change
    rename_column :users, :password, :crypted_password
  end
end
