class Comic < ActiveRecord::Base
  include Sort
  
  has_many :episodes
  belongs_to :category
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name
  
  def main_image
    image.exists? || (episodes.order(:sort).first && episodes.order(:sort).first.main_image)
  end
end
