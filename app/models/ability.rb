# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :read, :all

      if user.has_role? :admin
        can :manage, :all
      end
      
    else
      can :read, :all
    end
  end
end
