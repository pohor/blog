class AddForeignKeyCOrrect < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :articles, :users
  end
end
