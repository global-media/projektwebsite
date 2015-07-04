class Order < ActiveRecord::Base
  has_many :order_items
  alias :items :order_items

  belongs_to :customer
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'
  
  STATUSES = {1 => 'Open',
              2 => 'Processed',
              3 => 'Cancel'}.freeze

  attr_accessor :freeze_discount
  
  def status; STATUSES[status_id];  end
  
  def open!;    update_attribute(:status_id, Order.status_id?('Open'));  end
  def cancel!;  update_attribute(:status_id, Order.status_id?('Cancel'));  end
  def process!; update_attribute(:status_id, Order.status_id?('Processed'));  end
  
  def opened?;      status_id == Order.status_id?('Open');      end
  def cancelled?;   status_id == Order.status_id?('Cancel');    end
  def processed?;   status_id == Order.status_id?('Processed'); end
  
  class << self
    def open!(order_id);      Order.find(order_id).open!;     end
    def cancel!(order_id);    Order.find(order_id).cancel!;   end
    def process!(order_id);   Order.find(order_id).process!;  end

    def status_id?(status_name)
      STATUSES.detect {|k,v| v == status_name}.first || 1
    end
  end
  
  def update_items(order_items)
    self.order_items = []
    order_items.each do |k, v|
      order_item = OrderItem.find(k)
      order_item.update_attributes(v)
      self.order_items << order_item
    end
    save
  end
  
  def calculate!
    calculate_subtotal!
    calculate_discount! unless freeze_discount
    self.total = subtotal - discount + tax + shipping
    save!
  end

  def calculate_subtotal!
    self.subtotal = items.inject(0) {|subtotal, i| subtotal += (i.original_price * i.quantity)}
  end
  
  def calculate_discount!
    self.discount = items.inject(0) {|discount, i| discount += (i.discount * i.quantity)}
  end
end
