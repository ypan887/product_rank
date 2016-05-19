class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.date :date, null: false
      t.jsonb :posts, null: false, default: '{}'
    end

    add_index :archives, :posts, using: :gin
  end
end
