class Banner < ActiveRecord::Base
  include Sort
  
  has_many :images
  
  has_attached_file :image, :styles => { :medium => "682x225>", :small => "341x113>", :thumb => "170x56>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :image, dimensions: { width: 1366, height: 450 }
  
  validates_presence_of :name#, :link_url, :publish_at, :retract_at
  
  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())") }

  before_create :initialize_sort!

end
