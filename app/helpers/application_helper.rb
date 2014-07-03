module ApplicationHelper
  def verify_yourself_or_admin(id)
    id == current_diner.id || current_diner.role == 'admin'
  end
end
