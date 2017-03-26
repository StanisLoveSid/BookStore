class Order < ApplicationRecord
  include AASM

  has_many :order_items

  before_save :update_subtotal

  belongs_to :credit_card
  belongs_to :delivery
  belongs_to :user
  belongs_to :order_status

  accepts_nested_attributes_for :order_items

  STATES = [:in_delivery, :delivered, :canceled]

  has_one :order_shipping,
    -> { where addressable_type: 'order_shipping' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy
  has_one :order_billing,
    -> { where addressable_type: 'order_billing' },
    class_name: Address, foreign_key: :addressable_id,
    dependent: :destroy

  aasm do
    state :in_progress, :initial => true
    state :filled
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :fill do
      transitions  from: :in_progress, to: :filled
    end

    event :complete do
      transitions :from => :filled, :to => :in_queue
    end
  end

  def price_calc
    @price = order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    @if_discount = coupon == '1111' ? @price/4 : @price
  end

  def coupon_price
    price_calc
    @price - @if_discount
  end

  def subtotal
    price_calc
    delivery.price = 0 if order_items.size == 0 && !delivery.nil?
    @if_discount += delivery.price if !delivery.nil?
  end


  def update_subtotal
    self[:subtotal] = subtotal
  end
end
