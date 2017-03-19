class AddressForm < Rectify::Form
  attribute :first_name,       String
  attribute :last_name,        String
  attribute :address,          String
  attribute :city,             String
  attribute :zipcode,          String
  attribute :phone,            String
  attribute :addressable_type, String
  attribute :addressable_id,   Integer
  attribute :addressable_type, String
  attribute :addressable_id,   Integer
end
