# README

## データベースの設計
以下、\*は主キー


### messagesテーブル
チャットでやりとりするテキストやイメージを保存するテーブルのカラム


|   カラム   |        型         |     制限     |
|------------|-------------------|--------------|
| message    | text              |              |
| user_id    | references :user  |              |
| group_id   | references :group | （add index） |


<br>

### usersテーブル
ユーザー情報を保存するテーブルのカラム

|   カラム   |    型    |     制限     |
|------------|----------|--------------|
| name       | string   |              |
| email      | text     | unique: true |
| password   | string   |              |

<br>

### groupsテーブル
グループ情報を保存するテーブルのカラム

|   カラム   |    型    |     制限     |
|------------|----------|--------------|
| name       | string   |              |

<br>

### group_usersテーブル
グループとユーザーの対応関係を保存するテーブルのカラム

|  カラム  |        型         |      制限     |
|----------|-------------------|---------------|
| user_id  | references :user  |               |
| group_id | references :group | （add index） |


<br>

#### アソシエーション
##### メッセージテーブル
すべてのメッセージは一つのユーザーに属している  
すべてのメッセージは一つのグループに属している  

    class Message < ActiveRecord::Base
      belongs_to :user
      belongs_to :group
    end

##### ユーザーテーブル
すべてのユーザーは０以上のメッセージを持っている  
すべてのユーザーは０以上のグループとの対応関係を持っている  
※リレーションテーブルを作って第一正規化したので、has_many throughを使い複数のグループを持つことを示す  

    class User < ActiveRecord::Base
      has_many :messages
      has_many :relations
      has_many :groups, through: :relations
    end

##### グループテーブル
すべてのグループは０以上のメッセージを持っている  
すべてのグループは０以上のユーザーとの対応関係を持っている  
※リレーションテーブルを作って第一正規化したので、has_many throughを使い複数のユーザーを持つことを示す  

    class Group < ActiveRecord::Base
      has_many :messages
      has_many :relations
      has_many :users, through: :relations
    end

##### リレーションテーブル
すべてのリレーションは一つのユーザーに属している  
すべてのリレーションは一つグループに属している  

    class Group_user < ActiveRecord::Base
      belongs_to :user
      belongs_to :group
    end