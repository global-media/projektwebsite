class AddAdditionalImages < ActiveRecord::Migration
  def change
    add_attachment :comics, :banner_image
    add_attachment :episodes, :banner_image
  end
end
