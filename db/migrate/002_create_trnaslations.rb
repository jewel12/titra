class CreateTrnaslations < ActiveRecord::Migration
  def self.up
    create_table :trnaslations do |t|
      t.string :title
      t.integer :is_translated
      t.text :url
      t.timestamps
      t.integer :headline
      t.integer :account
    end
  end

  def self.down
    drop_table :trnaslations
  end
end
