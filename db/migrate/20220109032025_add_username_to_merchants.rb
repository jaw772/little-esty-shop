class AddUsernameToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :username, :string
  end
end
