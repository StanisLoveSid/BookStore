class UpdateAddress < Rectify::Command
  def initialize(address, current_user)
    @address = address.address
    @type = address.addressable_type
    @id = address.addressable_id
    @current_user = current_user
  end

  def call
    return broadcast(:invalid) unless @address && @type
    transaction do
      if @id.blank?
        set_addressable_id
        add_new_address
      else
        update_user
      end
    end
    broadcast :ok
  end

  private

  def add_new_address
    Address.create(@address)
  end

  def set_addressable_id
    @address[:addressable_id] = @current_user.id
  end

  def update_user
    @current_user.public_send(@type).update(@address)
  end
end