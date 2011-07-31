class CreateVotings < ActiveRecord::Migration
  def self.up
    create_table :votings do |t|
      t.string :title
      t.text :description
      t.text :public_key

      t.timestamps
    end
  end

  def self.down
    drop_table :votings
  end
end
