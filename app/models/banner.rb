class Banner < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_create :initialize_sort!
  
  validates_presence_of :name, :image_url, :link_url, :publish_at, :retract_at
  
  class << self
    def sort!(sorting_banners)
      sorted_banners = sorting_banners.sort do |x, y|
                        a, b = [x.last, y.last]
                        if (a['new'].to_i <=> b['new'].to_i) == 0
                          a['old'].to_i <=> b['old'].to_i
                        else
                          a['new'].to_i <=> b['new'].to_i
                        end
                      end
      
      sorted_banners.inject(1) do |count, banner_row|
        banner_id = banner_row.first
        Banner.find(banner_id).update_attribute(:sort, count)
        count += 1
      end
    end
  end
  
  protected
    
    def initialize_sort!
      self.sort = Banner.all.collect(&:sort).sort.last + 1
    end
end
