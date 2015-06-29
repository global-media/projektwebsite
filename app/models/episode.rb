class Episode < ActiveRecord::Base
  include Sort
  
  has_many :images
  belongs_to :comic
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name
  
  def main_image
    image.exists? || (images.order(:sort).first && images.order(:sort).first.image)
  end
end
