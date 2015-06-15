class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string      :title
      t.string      :author
      t.string      :photographer
      t.date        :date
      t.string      :image_url
      t.string      :description
      t.string      :keyword
      t.text        :content
      t.references  :category
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :image
      t.integer     :category_id
      t.timestamps  null: false
    end
  end
end
