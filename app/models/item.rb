class Item < ApplicationRecord
  before_create :generate_slug

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :description
  validates :price, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates :inventory, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  def self.popular_items(quantity)
    select('items.*, sum(order_items.quantity) as total_ordered')
      .joins(:orders)
      .where('orders.status != ?', :cancelled)
      .where('order_items.fulfilled = ?', true)
      .group('items.id, order_items.id')
      .order('total_ordered desc')
      .limit(quantity)
  end

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.downcase.delete(" ") + SecureRandom.uuid if name
  end
end
