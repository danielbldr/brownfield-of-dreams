class AddGithubNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_name, :string
    add_column :users, :token, :string
  end
end
