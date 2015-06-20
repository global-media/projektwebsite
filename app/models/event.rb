class Event < ActiveRecord::Base
  has_one :category
  
  validates_presence_of :name, :description, :venues
end
