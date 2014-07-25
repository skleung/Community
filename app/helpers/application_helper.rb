module ApplicationHelper
  def verify_yourself_or_admin(id)
    id == current_diner.id || is_admin?
  end

  def verify_yourself_or_group_admin(id)
    is_group_admin? || verify_yourself_or_admin(id)
  end

  def is_group_admin?
    @group_admin_authenticated.nil? ? @group_admin_authenticated = current_group.admin == current_diner : @group_admin_authenticated
  end

  def is_admin?
    @admin_authicated.nil? ? @admin_authicated = current_diner.role == 'admin' : @admin_authicated
  end
end
