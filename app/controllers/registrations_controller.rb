class RegistrationsController < Devise::RegistrationsController
	def create
		build_resource(sign_up_params)

		if resource.save
		  sign_up(resource_name, resource)
		  redirect_to root_path
		else
			respond_to do |format|
				format.html {
					clean_up_passwords resource
					respond_with resource
				}
			end
		end
	end
end
