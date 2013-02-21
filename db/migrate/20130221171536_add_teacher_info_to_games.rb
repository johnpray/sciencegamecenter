class AddTeacherInfoToGames < ActiveRecord::Migration
  def change
    add_column :games, :teacher_info, :text
  end
end
