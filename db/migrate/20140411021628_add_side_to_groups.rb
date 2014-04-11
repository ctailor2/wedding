class AddSideToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :side, :string
  end

  def down
    remove_column :groups, :side, :string
  end
end
