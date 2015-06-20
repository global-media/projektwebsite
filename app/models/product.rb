class Product < ActiveRecord::Base
  include Sort
  
  has_and_belongs_to_many :collections

  has_many :product_items, -> { order :sort}
  alias :items :product_items
  
  has_attached_file :main_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :main_image, :content_type => /\Aimage\/.*\Z/
  
  has_attached_file :detail_image1, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :detail_image1, :content_type => /\Aimage\/.*\Z/

  has_attached_file :detail_image2, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :detail_image2, :content_type => /\Aimage\/.*\Z/

  has_attached_file :detail_image3, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :detail_image3, :content_type => /\Aimage\/.*\Z/
  
  has_attached_file :detail_image4, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :detail_image4, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :name, :base_price, :base_sku, :main_image
  validates_uniqueness_of :name, :scope => [:base_sku]
  
  before_create :initialize_sort!
  before_save :set_collections
  
  attr_accessor :collection_ids
  

  protected
  
    def set_collections
      self.collections = []
      collection_ids.each do |collection_id|
        next if collection_id.blank?
        self.collections << Collection.find(collection_id)
      end
    end
end
