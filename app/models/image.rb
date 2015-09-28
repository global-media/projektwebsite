class Image < ActiveRecord::Base
  include Sort
  
  belongs_to :content, :polymorphic => true
  belongs_to :banner, -> { where("images.content_type = 'Banner'") }, foreign_key: 'content_id'
  belongs_to :category, -> { where("images.content_type = 'Category'") }, foreign_key: 'content_id'
  belongs_to :collection, -> { where("images.content_type = 'Collection'") }, foreign_key: 'content_id'
  belongs_to :comic, -> { where("images.content_type = 'Comic'") }, foreign_key: 'content_id'
  belongs_to :episode, -> { where("images.content_type = 'Episode'") }, foreign_key: 'content_id'
  belongs_to :gallery, -> { where("images.content_type = 'Gallery'") }, foreign_key: 'content_id'
  belongs_to :news, -> { where("images.content_type = 'News'") }, foreign_key: 'content_id'
  belongs_to :product, -> { where("images.content_type = 'Product'") }, foreign_key: 'content_id'
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  before_create :initialize_sort!
  
  def sort_group_by; {:content_id => content_id, :content_type => content_type}; end
end
