class UsersController < ApplicationController

  def update
    @address = AddressForm.from_params(params)
    if @address.valid?
      UpdateAddress.call(@address, current_user)
    else
      address_validation_error @address
    end
    redirect_to edit_user_registration_path
  end

  def address_validation_error address
    flash[params[:address][:addressable_type]] = address.errors
  end
end
