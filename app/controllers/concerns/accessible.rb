module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_admin
      flash.clear
      redirect_to(admins_authenticated_root_path) and return
    elsif current_employee
      flash.clear
      redirect_to(root_path) and return
    end
  end
end
