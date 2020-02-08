class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # relationshipsテーブルは中間テーブル
      # 外部キーとしての設定をするためにオプションは「foreign_key: true」
      t.references :user, foreign_key: true
      # 注意したいのがfollow_idの参照先のテーブルはusersテーブルにしてあげたいので、{to_table: :users}としてあげます。
      # foreign_key: trueにすると存在しないfollowsテーブルを参照してしまうから
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      # t.index [:user_id, :follow_id], unique: true は、 user_id と follow_id の
      # ペアで重複するものが保存されないようにするデータベースの設定
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
