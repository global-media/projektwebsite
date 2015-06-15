class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string      :name
      t.date        :date
      t.string      :venues
      t.references  :category
      t.text        :description
      t.datetime    :publish_at
      t.datetime    :retract_at
      t.integer     :category_id
      t.timestamps  null: false
    end
  end
end
