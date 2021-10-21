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

  def destroy?
    create?
  end
end
