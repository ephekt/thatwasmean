class AddIpToThing < ActiveRecord::Migration
  def self.up
    add_column :things, :ip, :string, :null => false
  end

  def self.down
    remove_column :things, :ip, :string, :null => false    
  end
end
