class Gift < ApplicationRecord
  has_many :gift_memberships, dependent: :destroy
  has_many :people, -> { order(:last_name, :first_name) }, through: :gift_memberships
end
