class Episode < ActiveRecord::Base
  include Sort

  belongs_to :comic
  
  has_many :images, as: :content, inverse_of: :content, dependent: :destroy
  
  validates_presence_of :name
  
  scope :premium, -> { where("1=1") }
  scope :popular, -> { where("1=1") }
  scope :latest, -> { order(:publish_at) }
  scope :active, -> { where("episodes.publish_at < NOW() AND (episodes.retract_at IS NULL OR episodes.retract_at > NOW())").includes(:comic).where("comics.publish_at < NOW() AND (comics.retract_at IS NULL OR comics.retract_at > NOW())").references(:comic) }
  
  before_create :initialize_sort!
  
  def sort_group_by; :comic_id; end
  
  def image
    images.order(:sort).first && images.order(:sort).first.image
  end
  
  def url_name
    id #CGI.escape(name)
  end
end
