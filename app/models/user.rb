class User < ApplicationRecord
  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      first_name: params['info']['name'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  def image
    self.authentications.last.params[:info][:image] if !self.authentications.last.nil?
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :categories
  has_many :orders
  has_many :credit_cards, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one :shipping, -> { where addressable_type: 'shipping' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy
  has_one :billing, -> { where addressable_type: 'billing' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy

end
