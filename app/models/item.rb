class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_fee_status
  belongs_to :scheduled_delivery
  belongs_to :prefecture
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :info, presence: true, length: { maximum: 1000 }
  validates :image, :category_id, :state_id, :shipping_fee_status_id,
            :prefecture_id, :scheduled_delivery_id, presence: true
  
  validates :price, presence: true,
            numericality: {
            greater_than_or_equal_to: 300,
            less_than_or_equal_to: 9999999,
            message: '¥300~¥9,999,999の範囲の半角数字で入力してください' 
            }

  validates :category_id, :state_id, :shipping_fee_status_id, :scheduled_delivery_id,
            :prefecture_id, numericality: { other_than: 1 , message: "can't be blank" } 

  belongs_to :user
  has_one_attached :image
end
