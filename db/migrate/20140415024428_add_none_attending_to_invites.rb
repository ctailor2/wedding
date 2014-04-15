class AddNoneAttendingToInvites < ActiveRecord::Migration
  def up
    add_column :invites, :none_attending, :boolean, default: false
  end

  def down
    remove_column :invites, :none_attending, :boolean
  end
end
