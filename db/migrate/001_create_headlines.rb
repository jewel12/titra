class CreateHeadlines < ActiveRecord::Migration
  def self.up
    create_table :headlines do |t|
      t.string :title
      t.text :url
      t.timestamps
    end
  end

  def self.down
    drop_table :headlines
  end
end
