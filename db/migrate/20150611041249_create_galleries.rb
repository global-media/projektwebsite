class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string      :name
      t.string      :description
      t.string      :image_url
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :image1
      t.attachment  :image2
      t.attachment  :image3
      t.attachment  :image4
      t.attachment  :image5
      t.attachment  :image6
      t.integer     :category_id
      t.timestamps  null: false
    end
  end
end
