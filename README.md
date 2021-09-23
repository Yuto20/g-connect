# アプリケーション名
「G-connect（ジーコネクト）」

# アプリケーション概要
ゲーム仲間を探している人同士でマッチングできるアプリケーションです。
# URL

https://g-connect-36561.herokuapp.com/
# テスト用アカウント
Test
<br>
メールアドレス：test@test.com
<br>
パスワード：test11

Sample
<br>
メールアドレス：sample@sample.com
<br>
パスワード：sample11

# 利用方法
新規登録もしくはログイン後、ユーザー一覧ページにて、気になるユーザーの詳細ページ遷移します。そこでユーザーをフォローしたり、チャットを行うことができます。

# 目指した課題解決
現在使用されている掲示板サイトではマッチングだけを目的としているのですが、このアプリケーションはユーザー同士のコミュニケーションもできるので、既存のサイトよりもミスマッチングが減るようにすることを目指しました。

# 洗い出した要件
[![Image from Gyazo](https://i.gyazo.com/1818494bdb29d29c4671d1061da4ab96.png)](https://gyazo.com/1818494bdb29d29c4671d1061da4ab96)

# 実装した機能についての画像やGIFおよびその説明
- プラットフォーム、ゲーム名を選択して検索すると、該当のデータを持ったユーザーが一覧表示されます。
<br>
[![Image from Gyazo](https://i.gyazo.com/b1593032d3470fc8ca18441cf3584e20.gif)](https://gyazo.com/b1593032d3470fc8ca18441cf3584e20)

- ユーザーをフォローまたはフォロー解除することができます。
<br>
[![Image from Gyazo](https://i.gyazo.com/4abf90662923637a26492f79d5e3c594.gif)](https://gyazo.com/4abf90662923637a26492f79d5e3c594)

- 他のユーザーと一対一のリアルタイムチャットができます。
<br>
[![Image from Gyazo](https://i.gyazo.com/98664ea8b6ad85403cb309e4d6406e1a.gif)](https://gyazo.com/98664ea8b6ad85403cb309e4d6406e1a)

# 実装予定の機能
- 通知機能
- ユーザーのログイン状態の可視化
- ユーザーの最終ログイン時間の表示


# データベース設計
## テーブル設計
<br>

### ER図
![g_connect](https://user-images.githubusercontent.com/88032726/134527257-9a8c28c6-2fcf-41c1-a1e6-b117e10c05c0.png)

<br>

### usersテーブル（ユーザー情報）

| Column             | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| age_id             | integer |                           |
| sex_id             | integer |                           |
| voice_id           | integer | null: false               |
| profile            | text    | null: false               |

#### Association

- has_many :rooms, through: :entries
- has_many :entries, dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :relationships, foreign_key: :following_id, dependent: :destroy
- has_many :followings, through: :relationships, source: :follower
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
- has_many followers, through: :reverse_of_relationships, source: :following

<br>

### roomsテーブル（チャットルーム情報）

| Column | Type   | Option |
| ------ | ------ | ------ |
| name   | string |        |

#### Association

- has_many users, through: :entries
- has_many :entries, dependent: :destroy
- has_many :messages, dependent: :destroy

<br>

### entriesテーブル（usersテーブルとroomsテーブルの中間テーブル）

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :room

<br>

### messagesテーブル（チャットルーム内のメッセージ情報）

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :room
- has_many :notifications, dependent: :destroy

<br>

### relationshipsテーブル（ユーザーのフォロー、フォロワー情報）

| Column       | Type    | Option      |
| ------------ | ------- | ----------- |
| following_id | integer | null: false |
| follower_id  | integer | null: false |

#### Association

- belongs_to :following, class_name 'User'
- belongs_to :follower,  class_name 'User'

<br>

# ローカルでの動作方法
## 開発環境
- ruby 2.6.5
- rails 6.0.0