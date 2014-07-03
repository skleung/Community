module DinersHelper
  def verify_yourself_or_admin
    @diner.id == current_diner.id || current_diner.role == 'admin'
  end
end
