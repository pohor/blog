class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :value, :integer, default: 0
  end
end
