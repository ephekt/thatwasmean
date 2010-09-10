class RemoveThingColumnsAndAddEnums < ActiveRecord::Migration
  def self.up
    remove_column :things, :vote_for
    remove_column :things, :vote_against
    remove_column :things, :disputed
    change_column :things, :category, :enum, :limit => [:mean, :nice, :wierd], :default => :mean
  end

  def self.down
    add_column :things, :vote_for, :integer
    add_column :things, :vote_against, :integer
    add_column :things, :disputed, :boolean    
    change_column :things, :category, :string    
  end
end
