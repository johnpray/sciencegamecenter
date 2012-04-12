class AddAttachmentBoxartToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :boxart_file_name, :string
    add_column :games, :boxart_content_type, :string
    add_column :games, :boxart_file_size, :integer
    add_column :games, :boxart_updated_at, :datetime
  end

  def self.down
    remove_column :games, :boxart_file_name
    remove_column :games, :boxart_content_type
    remove_column :games, :boxart_file_size
    remove_column :games, :boxart_updated_at
  end
end
