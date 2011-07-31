class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :voter_name
      t.string :voter_surname1
      t.string :voter_surname2
      t.string :voter_cif
      t.text :encrypted_vote
      t.text :dnie_certificate
      t.text :signed_votes
      t.text :votes_signature

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
