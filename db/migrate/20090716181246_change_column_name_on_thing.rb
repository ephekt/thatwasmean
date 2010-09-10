class ChangeColumnNameOnThing < ActiveRecord::Migration
  def self.up
    change_column :things, :category, :enum, :limit => [:nice, :mean, :weird], :default => :mean
  end

  def self.down
    change_column :things, :category, :enum, :limit => [:nice, :mean, :weird], :default => :mean    
  end
end
