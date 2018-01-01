require 'active_support/concern'

module Concerns
  module Person
    module GiftMemberships
      extend ActiveSupport::Concern

      included do
        has_many :gift_memberships, dependent: :destroy
        has_many :gifts, through: :gift_memberships
        after_destroy :destroy_gift_memberships
      end

      def has_gift?(gift)
        gift_memberships.where(gift_id: gift.id).any?
      end

      def has_any_gift?()
        gift_memberships.all().any?
      end

      def destroy_gift_memberships
        gift_memberships.destroy_all
      end
    end
  end
end
