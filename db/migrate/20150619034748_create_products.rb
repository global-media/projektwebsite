class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string      :name
      t.string      :metadata
      t.string      :description
      t.integer     :sort
      t.string      :base_sku
      t.decimal     :base_price, precision: 15, scale: 2
      t.decimal     :sale_price, precision: 15, scale: 2
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.attachment  :main_image
      t.attachment  :detail_image1
      t.attachment  :detail_image2
      t.attachment  :detail_image3
      t.attachment  :detail_image4
      t.timestamps  null: false
    end
  end
end
