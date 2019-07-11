class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters,if: :devise_controller?
	before_action :authenticate_user!


	def after_sign_in_path_for(resource)
		user_path(resource)
	end
	def after_sign_up_path_for(resource)
		user_path(resource)
	end
	def after_sign_out_path_for(resource)
		root_path
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
		devise_parameter_sanitizer.permit(:sign_in,keys:[:name])
		devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
		#devise_parameter_sanitizer.permit(:sign_in,except:[:email])
		devise_parameter_sanitizer.permit(:account_update,keys:[:introduction])
		devise_parameter_sanitizer.permit(:account_update,keys:[:profile_image_id])
	end
end
