require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
      sleep(1)
    end 

    describe '商品購入記録と配送先住所の保存' do
      context '保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_destination).to  be_valid
      end

      it 'buildingは空でも保存できる' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '保存できない場合' do
      it 'userが紐づいていなければ保存できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ保存できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空では保存できない' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'cityが空では保存できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空では保存できない' do
        @order_destination.addresses = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'postal_codeが数字以外の文字を含む場合、保存できない' do
        @order_destination.postal_code = 'a12-3456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Input harf size numbers with hyphen(-)")
      end
      
      it 'postal_codeが全角数字を含む場合、保存できない' do
        @order_destination.postal_code = '01２-3456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Input harf size numbers with hyphen(-)")
      end

      it 'postal_codeがハイフンを含まなければ保存できない' do
        @order_destination.postal_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Input harf size numbers with hyphen(-)")
      end

      it 'postal_codeのハイフンの前が３桁でない場合、保存できない' do
        @order_destination.postal_code = '1234-5678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Input harf size numbers with hyphen(-)")
      end

      it 'postal_codeのハイフンの後が４桁でない場合、保存できない' do
        @order_destination.postal_code = '123-45678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Input harf size numbers with hyphen(-)")
      end

      it 'prefectureが--では保存できない' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'phone_numberが数字以外の文字を含む場合、保存できない' do
        @order_destination.phone_number = '012a3456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input 10 or 11 digit harf size numbers without hyphen(-)")
      end

      it 'phone_numberが全角数字を含む場合、保存できない' do
        @order_destination.phone_number = '012３3456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input 10 or 11 digit harf size numbers without hyphen(-)")
      end

      it 'phone_numberが10桁未満の場合、保存できない' do
        @order_destination.phone_number = '123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input 10 or 11 digit harf size numbers without hyphen(-)")
      end

      it 'phone_numberが11を超過する桁の場合、保存できない' do
        @order_destination.phone_number = '012345678912'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input 10 or 11 digit harf size numbers without hyphen(-)")
      end

      it 'phone_numberがハイフンを含む場合、保存できない' do
        @order_destination.phone_number = '012-34567891'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input 10 or 11 digit harf size numbers without hyphen(-)")
      end

      it 'tokenが空では保存できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
