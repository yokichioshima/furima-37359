class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :nickname, :birth_date, presence: true
  validates :last_name, :first_name,
              presence: true,
              format: { 
                     with: /\A[ぁ-んァ-ン一-龥]+\z/,
                     message: 'に全角文字を使用してください' 
              } 
  validates :last_name_kana, :first_name_kana, 
              presence: true,
              format: {
                     with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                     message: "全角カタカナのみで入力して下さい"
               }

end
