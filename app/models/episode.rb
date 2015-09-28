class Episode < ActiveRecord::Base
  include Sort
  include UrlName
  
  belongs_to :comic
  
  has_many :images, as: :content, inverse_of: :content, dependent: :destroy

  # NORMAL THUMBNAIL IMAGE
  has_attached_file :image, :styles => { :medium => "200x200>", :small => "100x100>", :thumb => "50x50>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # validates :image, dimensions: { width: 400, height: 400 }
  
  # LATEST BANNER IMAGE
  has_attached_file :banner_image, :styles => { :medium => "300x100>", :small => "150x50>", :thumb => "75x25>" }, :default_url => "/system/defaults/no_image.png"
  validates_attachment_content_type :banner_image, :content_type => /\Aimage\/.*\Z/
  validates :banner_image, dimensions: { width: 600, height: 200 }

  validates_presence_of :name
  
  scope :sort, -> { order(:sort) }
  scope :premium, -> { where("1=1") }
  scope :popular, -> { where("1=1").order(publish_at: 'desc') } #TODO
  scope :latest, -> { where("episodes.banner_image_file_name IS NOT NULL").order(:publish_at) }
  scope :active, -> { where("episodes.publish_at < NOW() AND (episodes.retract_at IS NULL OR episodes.retract_at > NOW())").includes(:comic).where("comics.publish_at < NOW() AND (comics.retract_at IS NULL OR comics.retract_at > NOW())").references(:comic) }
  
  before_create :initialize_sort!
  
  class << self
    def find_by_url_name(episode_url_name)
      find(get_identifier(episode_url_name))
    end    
  end
  
  # def image
  #   (images.order(:sort).first && images.order(:sort).first.image)
  # end  
  
  def url_name
    id.to_s + SEPARATOR + self.class.normalize_name(comic.name) + SEPARATOR + self.class.normalize_name(name)
  end
  
  def sort_group_by; {:comic_id => comic_id}; end
  
  def rating
    2.43.floor
  end
  
  def first?
    sort == 1
  end
  
  def last?
    sort == comic.episodes.last.sort
  end
  
  def previous
    Episode.where(sort: sort-1, comic_id: comic.id).first || self
  end
  
  def next
    Episode.where(sort: sort+1, comic_id: comic.id).first || self
  end
  
  def related_comics
    Comic.where("id != #{id}")
  end
end
