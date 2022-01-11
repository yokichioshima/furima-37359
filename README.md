## usersテーブル
| Column                 | Type    | Options                        |
| ---------------------- | ------- | ------------------------------ |
| nickname               | string  | null: false                    |
| email                  | string  | null: false                    |
| encrpted_password      | string  | null: false                    |
| last_name              | string  | null: false                    |
| first_name             | string  | null: false                    |
| last_name_kana         | string  | null: false                    |
| first_name_kana        | string  | null: false                    |
| birth_year             | integer | null: false                    |
| birth_month            | integer | null: false                    |
| birth_date             | integer | null: false                    |

### Association
- has_many :products
- has_many :purchases



## itemsテーブル
| Column                 | Type    | Options                        |
| ---------------------- | ------- | ------------------------------ |
| image                  | string  | null: false                    |
| name                   | string  | null: false                    |
| info                   | text    | null: false  maxlength: 1000   |
| category               | integer | null: false                    |
| state                  | integer | null: false                    |
| price                  | integer | null: false                    |
| user_id                | integer | null: false, foregin_key: true |
| shipping_fee_status_id | integer | null: false                    |
| prefecture_id          | integer | null: false                    |
| scheduled_delivery_id  | integer | null: false                    |
| price                  | integer | null: false                    |

### Association
- belongs_to :user
- has_one :purchase



## purchasesテーブル
| Column                 | Type    | Options                        |
| ---------------------- | ------- | ------------------------------ |
| postal_code            | text    | null: false                    |
| prefecture             | integer | null: false                    |
| city                   | text    | null: false                    |
| addresses              | text    | null: false                    |
| building               | text    | null: false                    |
| phone_number           | text    | null: false                    |

### Association
- belongs_to :user
- belongs_to :item
