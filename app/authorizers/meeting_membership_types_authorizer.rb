class MeetingMemberhipTypesAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    # pubic, visible-to-everyone membership types
    if !(resource.hidden? || resource.private?)
      true
    # user is a member of the membership types
    elsif user.member_of?(resource)
      true
    # user is admin who manages memberships types
    elsif user.admin?(:manage_meeting_memberships_types)
      true
    end
  end

  def updatable_by?(user)
    # user is an admin of the membership type
    if user.member_of?(resource) && resource.admin?(user)
      true
    # user is global admin with manage_meeting_memberships_types privilege
    elsif user.admin?(:manage_meeting_memberships_types)
      true
    end
  end

  alias deletable_by? updatable_by?
end
