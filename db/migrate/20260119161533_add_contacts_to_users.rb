class AddContactsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :whatsapp, :string
    add_column :users, :linkedin, :string
    add_column :users, :github_url_admin, :string
  end
end
