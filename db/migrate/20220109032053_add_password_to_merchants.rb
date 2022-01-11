class AddPasswordToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :password_digest, :string
  end
end
