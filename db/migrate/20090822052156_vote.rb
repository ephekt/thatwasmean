class Vote < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.boolean :for, :default => false, :null => false
      t.integer :user_id, :null => false
      t.integer :thing_id, :null => false
    end
  end

  def self.down
    drop_table :votes
  end
end
