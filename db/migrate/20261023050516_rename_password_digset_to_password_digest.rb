class RenamePasswordDigsetToPasswordDigest < ActiveRecord::Migration[8.1]
  def change
    if column_exists?(:users, :password_digset)
      rename_column :users, :password_digset, :password_digest
    end
  end
end