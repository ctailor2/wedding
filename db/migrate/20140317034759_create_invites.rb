class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
			t.belongs_to :event
			t.belongs_to :group
			t.integer :num_invited
      t.timestamps
    end
  end
end
