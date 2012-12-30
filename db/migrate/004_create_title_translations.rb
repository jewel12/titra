class CreateTitleTranslations < ActiveRecord::Migration
  def self.up
    create_table :title_translations do |t|
      t.integer :headline_id
      t.integer :translator_id
      t.text :title
      t.timestamps
    end
  end

  def self.down
    drop_table :title_translations
  end
end
