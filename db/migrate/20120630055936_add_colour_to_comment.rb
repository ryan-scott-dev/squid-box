class AddColourToComment < ActiveRecord::Migration
  def change
    add_column :comments, :colour, :string
  end
end
