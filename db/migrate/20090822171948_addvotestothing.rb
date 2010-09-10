class Addvotestothing < ActiveRecord::Migration
  def self.up
      add_column :things, :current_votes, :integer, :null => false, :default => 0
    end

    def self.down
      remove_column :things, :current_votes
  end
end
