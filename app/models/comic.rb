class Comic < ActiveRecord::Base
  include Sort
  include UrlName
  
  has_many :episodes, dependent: :destroy
  belongs_to :category
  
  has_many :tag_relations, as: :content, inverse_of: :content
  has_many :tags, through: :tag_relations
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_image.png" #600 x 200 px
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # validates :image, dimensions: { width: 1366, height: 450 }

  # BANNER HEADER IMAGE
  has_attached_file :banner_image, :styles => { :medium => "682x225>", :small => "341x113>", :thumb => "170x56>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :banner_image, :content_type => /\Aimage\/.*\Z/
  validates :banner_image, dimensions: { width: 1366, height: 450 }
  
  validates_presence_of :name
  
  scope :active, -> { where("publish_at < NOW() AND (retract_at IS NULL OR retract_at > NOW())") }
  
  before_create :initialize_sort!
  before_save :set_tags
  
  attr_accessor :tag_ids

  class << self
    def find_by_url_name(comic_url_name)
      find(get_identifier(comic_url_name))    
    end    
  end

  def main_image
    image.exists? || (episodes.order(:sort).first && episodes.order(:sort).first.image)
  end
  
  def category_name
    category ? category.name : ''
  end
  
  def url_name
    id.to_s + SEPARATOR + self.class.normalize_name(name)
  end
  
  def episode_image
    episodes.empty? ? image : episodes.first.image
  end
  
    
  protected

    def set_tags
      return if tag_ids.nil?
      self.tag_relations.to_a.each {|tr| tag_ids.include?(tr.tag_id.to_s) ? 
                                          tag_ids.delete(tr.tag_id.to_s) :
                                          tr.destroy}
      tag_ids.each do |tag_id|
        next if tag_id.blank?
        self.tags << Tag.find(tag_id)
      end
    end
end
