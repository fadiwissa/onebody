class AddSiteToGiftMembership < ActiveRecord::Migration[5.1]
  def change
    add_column :gift_memberships, :site_id, :integer
  end
end
