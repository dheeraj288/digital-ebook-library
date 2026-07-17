class CreateEbooks < ActiveRecord::Migration[7.1]
  def change
    create_table :ebooks do |t|
      t.string :title
      t.string :author
      t.text :description
      t.date :published_at
      t.string :file_type
      t.bigint :file_size

      t.timestamps
    end
  end
end
