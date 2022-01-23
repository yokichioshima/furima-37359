class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_fee_status
  belongs_to :scheduled_delivery
  belongs_to :prefecture

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :info, length: { maximum: 1000 }
    validates :category_id, :state_id, :shipping_fee_status_id,
              :prefecture_id, :scheduled_delivery_id,
              numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: {
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999,
      message: 'は¥300~¥9,999,999の範囲の半角数字で入力してください'
    }
  end

  belongs_to :user
  has_one_attached :image
  has_one :order
end
