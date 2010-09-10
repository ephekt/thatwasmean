class User < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :ip
    end    
  end

  def self.down
   drop_table :users
  end
end
