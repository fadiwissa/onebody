class GiftAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    # pubic, visible-to-everyone gift
    if !(resource.hidden? || resource.private?)
      true
    # user is a member of the gift
    elsif user.member_of?(resource)
      true
    # user is admin who manages gift
    elsif user.admin?(:manage_gifts)
      true
    end
  end

  def updatable_by?(user)
    # user is an admin of the gift
    if user.member_of?(resource) && resource.admin?(user)
      true
    # user is global admin with manage_gifts privilege
    elsif user.admin?(:manage_gifts)
      true
    end
  end

  alias deletable_by? updatable_by?
end
