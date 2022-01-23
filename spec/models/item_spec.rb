require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できる場合' do
      it 'user, image, name, info, category_id, state_id, shipping_fee_status_id,
      prefecture_id, scheduled_delivery_id, price が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'userが紐づいていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it '画像が存在しない場合は、出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      blank_check_list = [:name, :info, :price]

      blank_check_list.each do |key|
        it "#{key}が空では出品できない" do
          blank_check(@item, key)
        end
      end

      collection_select_blank_check_list = [:category_id, :state_id,
                                            :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id]

      collection_select_blank_check_list.each do |key|
        it "#{key}が--では出品できない" do
          collection_select_blank_check(@item, key)
        end
      end

      it 'nameが41文字以上の場合、出品できない' do
        @item.name = Faker::String.random(length: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end

      it 'infoが1001文字以上の場合、出品できない' do
        @item.info = Faker::String.random(length: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('Info is too long (maximum is 1000 characters)')
      end

      it 'priceが全角数字を含む場合、出品できない' do
        @item.price = '１234'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の範囲の半角数字で入力してください')
      end

      it 'priceが300円未満の場合、出品できない' do
        @item.price = Faker::Number.between(from: -1, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の範囲の半角数字で入力してください')
      end

      it 'priceが9,999,999より大きい場合、出品できない' do
        @item.price = Faker::Number.between(from: 10_000_000, to: 100_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の範囲の半角数字で入力してください')
      end
    end
  end
end
