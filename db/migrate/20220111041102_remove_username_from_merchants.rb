class RemoveUsernameFromMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :username, :string
  end
end
