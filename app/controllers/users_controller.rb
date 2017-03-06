class UsersController < ApplicationController
  load_resource

  def update
  	@user = current_user
    @address = AddressForm.from_params(params)
    UpdateAddress.call(@address) 
    redirect_to edit_user_registration_path
  end

end
