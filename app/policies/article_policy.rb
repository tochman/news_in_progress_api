class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @user
  end

  def create?
    @user.journalist? || @user.editor?
  end

  def update?
    @user.editor? || (@user.journalist? && @resource.authors.include?(@user))
  end

  def destroy?
    update?
  end
end
