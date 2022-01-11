## usersテーブル
| Column                 | Type    | Options                           |
| ---------------------- | ------- | --------------------------------- |
| nickname               | string  | null: false                       |
| email                  | string  | null: false, unique: true         |
| encrypted_password     | string  | null: false                       |
| last_name              | string  | null: false                       |
| first_name             | string  | null: false                       |
| last_name_kana         | string  | null: false                       |
| first_name_kana        | string  | null: false                       |
| birth_date             | date    | null: false                       |

### Association
- has_many :items
- has_many :buy_records



## itemsテーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| info                   | text       | null: false                    |
| category_id            | integer    | null: false                    |
| state_id               | integer    | null: false                    |
| user                   | references | null: false, foregin_key: true |
| shipping_fee_status_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |
| price                  | integer    | null: false                    |

### Association
- belongs_to :user
- has_one :buy_record



## delivery_addressesテーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| postal_code            | text       | null: false                    |
| prefecture_id          | integer    | null: false                    |
| city                   | string     | null: false                    |
| addresses              | string     | null: false                    |
| building               | string     |                                |
| phone_number           | string     | null: false                    |
| buy_record             | references | null: false, foreign_key: true |

### Association
- belongs_to :buy_record


## buy_recordsテーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| user                   | references | null: false, foreign_key: true |
| item                   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery_record