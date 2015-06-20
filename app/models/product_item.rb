class ProductItem < ActiveRecord::Base
  include Sort
  
  belongs_to :product
  
  before_create :initialize_sort!
  
  delegate :name, :to => :product
  
  def name_option
    str = name
    str << " (#{option})" unless option.blank?
    str << " [#{sku}]"
  end
end
