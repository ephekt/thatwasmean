class CreateThings < ActiveRecord::Migration
  def self.up
    create_table :things do |t|
      t.string :category
      t.text :thing
      t.integer :disputed
      t.integer :vote_for
      t.integer :vote_against

      t.timestamps
    end
  end

  def self.down
    drop_table :things
  end
end
