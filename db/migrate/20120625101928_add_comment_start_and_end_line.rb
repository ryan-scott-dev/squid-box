class AddCommentStartAndEndLine < ActiveRecord::Migration
  def change

    change_table :comments do |t|

      t.string :commit
      t.string :file

      t.integer :repository_id

      t.integer :start_line
      t.integer :end_line
    end

  end
end
