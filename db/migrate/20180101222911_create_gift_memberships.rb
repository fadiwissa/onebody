class CreateGiftMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :gift_memberships do |t|
      t.integer :person_id
      t.integer :gift_id

      t.timestamps
    end
  end
end
