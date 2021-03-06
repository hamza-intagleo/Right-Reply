class ApplicationController < ActionController::Base
  before_action :redirect_on_admin

  protected
    
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || (!resource.is_plan_confirm ? users_pricing_path : (resource.status == 'inactive' ? user_configuration_path(resource) : user_dashboard_path(resource, search_type: 'all'))) || root_path
  end

  def redirect_on_admin
    if user_signed_in? && (request.url.include?("/users/sign_up") || (params[:controller] == 'home' && params[:action] == 'index'))
      redirect_to user_dashboard_path(current_user, search_type: 'all') and return
    end
  end
end
