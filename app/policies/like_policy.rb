class LikePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index 
    false
  end

  def show
    false
  end

  def upadate
    false
  end

  def edit
    false
  end

  def create?
    user.present? && (record.user == user)
  end

  def destroy?
    create?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end