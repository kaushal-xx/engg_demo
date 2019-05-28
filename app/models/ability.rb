# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can [:index, :edit, :update], User, id: user.id
      cannot :manage, SecretCode

      if user.has_role? :admin # additional permissions for administrators
        can :manage, :all
      end
    end
  end
end
