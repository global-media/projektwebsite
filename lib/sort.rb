module Sort
  module ClassMethods
    attr_accessor :sort_group_by
    
    def sort!(sorting_records)
      sorted_records = sorting_records.sort do |x, y|
                        a, b = [x.last, y.last]
                        if (a['new'].to_i <=> b['new'].to_i) == 0
                          b['old'].to_i <=> a['old'].to_i
                        else
                          a['new'].to_i <=> b['new'].to_i
                        end
                      end
      
      sorted_records.inject(1) do |count, record_row|
        record_id = record_row.first
        find(record_id).update_attribute(:sort, count)
        count += 1
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend ClassMethods
  end
  
  protected
    
    def initialize_sort!
      conditions = "1=1"
      unless !respond_to?(:sort_group_by) || sort_group_by.blank?
        array = []
        sort_group_by.each do |key, value|
          array << "#{key.to_s} = '#{value}'"
        end
        conditions = array.join(' AND ')
      end
      
      self.sort = (self.class.where(conditions).collect(&:sort).compact.max || 0).next
    end
        
end