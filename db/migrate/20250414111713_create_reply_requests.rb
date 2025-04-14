class CreateReplyRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :reply_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.text :email
      t.string :tone
      t.text :ai_reply

      t.timestamps
    end
  end
end
