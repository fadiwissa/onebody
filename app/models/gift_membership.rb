class GiftMembership < ApplicationRecord
  include Authority::Abilities
  self.authorizer_name = 'GiftMembershipAuthorizer'

  belongs_to :gift
  belongs_to :person

  validates_uniqueness_of :gift_id, scope: %i(site_id person_id)

  scope_by_site_id

  scope :order_by_birthday, -> { order('ifnull(month(people.birthday), 99)') }
  scope :order_by_name,     -> { order('people.first_name, people.last_name') }
end