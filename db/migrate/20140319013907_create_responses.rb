class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
			t.belongs_to :invite
			t.belongs_to :member
      t.timestamps
    end
  end
end
