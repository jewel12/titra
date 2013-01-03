class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :headline_id
      t.integer :translator_id
      t.text :title
      t.text :summary
      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
