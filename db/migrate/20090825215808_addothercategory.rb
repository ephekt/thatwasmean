class Addothercategory < ActiveRecord::Migration
  def self.up
    change_column :things, :category, :enum, :limit => [:nice, :mean, :weird, :stupid, :hurricane, :funny, :other], :default => :mean
  end

  def self.down
    change_column :things, :category, :enum, :limit => [:nice, :mean, :weird, :stupid, :hurricane, :funny], :default => :mean
  end
end
