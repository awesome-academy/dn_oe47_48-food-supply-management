class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    can :read, Product, published: true
    can :read, Category, published: true
    return unless user

    case controller_namespace
    when "Admin"
      can :manage, :all if user.admin?
    else
      can :read, Order, user: user
      can :update, Order do |order|
        order.user_id = user.id
        order.status = :processing
      end
      can [:read, :update], User, user: user
      can [:read, :create], CartSession, user: user
    end
  end
end
