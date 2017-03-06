class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :categories
  has_many :orders
  has_many :credit_cards

  has_one :shipping, -> { where addressable_type: 'shipping' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy
  has_one :billing, -> { where addressable_type: 'billing' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy

end
