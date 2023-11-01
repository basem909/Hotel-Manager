class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Room, public: true

    return unless user.present? # additional permissions for logged in users (they can read their own posts)

    can :read, Room
    can :manage, Reservation, user_id: user.id

    return unless user.admin? # additional permissions for administrators

    can :manage, :all
  end
end
