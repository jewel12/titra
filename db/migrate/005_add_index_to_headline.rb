class AddIndexToHeadline < ActiveRecord::Migration
  def self.up
    add_index :headlines, :url
  end

  def self.down
    remove_index :headlines, :url
  end
end
