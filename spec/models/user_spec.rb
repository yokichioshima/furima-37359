require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do

      it 'nickname,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birth_date
      が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do

      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが５文字以下であれば登録できない' do
        @user.password = 'aaaa1'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")        
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailが@を含まない場合は登録できない' do
        @user.email = @user.email.gsub!(/@/, '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'last_nameが空である場合は登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空である場合は登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameが半角英数字を含む場合は登録できない' do
        @user.last_name[0] = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name に全角文字を使用してください")
      end

      it 'first_nameが半角英数字を含む場合は登録できない' do
        @user.first_name[0] = 'b'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name に全角文字を使用してください")
      end

      it 'last_name_kanaが空である場合は登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空である場合は登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end


      it 'last_name_kanaがカタカナ以外の文字を含む場合は登録できない' do
        @user.last_name_kana[0] = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナのみで入力して下さい")
      end

      it 'first_name_kanaがカタカナ以外の文字を含む場合は登録できない' do
        @user.first_name_kana[0] = 'い'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみで入力して下さい")
      end

      it 'birth_dateが空である場合は登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

    end
  end
end
