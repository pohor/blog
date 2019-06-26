class AddScoreToComments < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :comment, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
      t.index [:user_id, :comment_id], unique: true
    end
  end
end
