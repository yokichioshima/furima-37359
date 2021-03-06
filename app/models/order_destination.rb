class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :user_id, :item_id
    validates :postal_code,
              format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は3桁半角数字-4桁半角数字の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :city, :addresses
    validates :phone_number,
              format: { with: /\A[0-9]{10,11}\z/,
                        message: 'は-を含めず、10桁または11桁の数字を入力してください' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                       phone_number: phone_number, order_id: order.id)
  end
end
