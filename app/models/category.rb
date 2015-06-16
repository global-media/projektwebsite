class Category < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/system/defaults/no_thumbnail.gif"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_create :initialize_sort!
  
  validates_presence_of :name
  
  class << self
    def sort!(sorting_categories)
      sorted_categories = sorting_categories.sort do |x, y|
                        a, b = [x.last, y.last]
                        if (a['new'].to_i <=> b['new'].to_i) == 0
                          a['old'].to_i <=> b['old'].to_i
                        else
                          a['new'].to_i <=> b['new'].to_i
                        end
                      end
      
      sorted_categories.inject(1) do |count, category_row|
        category_id = category_row.first
        Category.find(category_id).update_attribute(:sort, count)
        count += 1
      end
    end
  end
  
  protected
    
    def initialize_sort!
      self.sort = Category.all.collect(&:sort).sort.last + 1
    end
end
