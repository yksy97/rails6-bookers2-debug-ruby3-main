class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :body
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
