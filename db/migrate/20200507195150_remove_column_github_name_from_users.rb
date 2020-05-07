class RemoveColumnGithubNameFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :github_name
  end

  def down
    add_column :users, :github_name, :string
  end
end
