class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birth_date, presence: true
  validates :password, 
            presence: true,
            format: {
              with: /\A(?=.*?[a-z])(?=.*?[0-9])[a-z0-9]+\z/,
              message: 'は半角英数字混合で入力してください'
            }
  validates :last_name, :first_name,
            presence: true,
            format: {
              with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
              message: 'は全角文字で入力してください'
            }
  validates :last_name_kana, :first_name_kana,
            presence: true,
            format: {
              with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
              message: 'は全角カタカナで入力して下さい'
            }
end
