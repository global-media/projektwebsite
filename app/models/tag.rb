class Tag < ActiveRecord::Base
  include Sort

  STATUSES = {1 => 'Available',
              2 => 'Retracted',
              3 => 'Hidden'}.freeze
              
  before_create :initialize_sort!
  
  def status_name
    STATUSES[status_id]
  end
end
