class RemovePasswordDigestFromMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :password_digest, :string
  end
end
