class ChangeReviewScoresToFloat < ActiveRecord::Migration
  def self.up
    change_table :player_reviews do |t|
      t.change :fun_rating, :float
      t.change :accuracy_rating, :float
      t.change :effectiveness_rating, :float
    end
  end
 
  def self.down
    change_table :player_reviews do |t|
      t.change :fun_rating, :integer
      t.change :accuracy_rating, :integer
      t.change :effectiveness_rating, :integer
    end
  end
end