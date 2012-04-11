class AddBirthDateAndDisabledToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
    add_column :users, :disabled, :boolean, default: false
  end
end
