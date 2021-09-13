# テーブル名

## usersテーブル（ユーザー情報）

| Column             | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| age_id             | integer |                           |
| sex_id             | integer |                           |
| voice_id           | integer | null: false               |
| profile            | text    | null: false               |

### Association

- has_many :rooms, through: :entries
- has_many :entries, dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :relationships, foreign_key: :following_id, dependent: :destroy
- has_many :followings, through: :relationships, source: :follower
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
- has_many followers, through: :reverse_of_relationships, source: :following
- has_many :active_notifications, class_name: 'Notification', foreign_key: visitor_id, dependent: :destroy
- has_many :passive_notifications, class_name: 'Notification', foreign_key: visited_id, dependent: :destroy


## roomsテーブル（チャットルーム情報）

| Column | Type   | Option |
| ------ | ------ | ------ |
| name   | string |        |

### Association

- has_many users, through: :entries
- has_many :entries, dependent: :destroy
- has_many :messages, dependent: :destroy


## entriesテーブル（usersテーブルとroomsテーブルの中間テーブル）

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room

## messagesテーブル（チャットルーム内のメッセージ情報）

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room
- has_many :notifications, dependent: :destroy

## relationshipsテーブル（ユーザーのフォロー、フォロワー情報）

| Column       | Type    | Option      |
| ------------ | ------- | ----------- |
| following_id | integer | null: false |
| follower_id  | integer | null: false |

### Association

- belongs_to :following, class_name 'User'
- belongs_to :follower,  class_name 'User'

## notificationsテーブル（通知情報）

| Column     | Type    | Option      |
| ---------- | ------- | ----------- |
| visitor_id | integer | null: false |
| visited_id | integer | null: false |
| message_id | integer |
| action     | string  | null: false |
| checked    | boolean | null: false |

### Association

- belongs_to :message, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true