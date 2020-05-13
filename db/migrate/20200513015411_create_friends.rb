class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.references :friended
    end

    add_foreign_key :friends, :users, column: :friended_id
  end
end
