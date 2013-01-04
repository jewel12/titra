class AddIndexToTranslation < ActiveRecord::Migration
  def self.up
    add_index :translations, :headline_id
    add_index :translations, :translator_id
  end

  def self.down
    remove_index :translations, :headline_id
    remove_index :translations, :translator_id
  end
end
