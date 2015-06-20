module OrdersHelper
  def order_status_options
    Order::STATUSES.collect {|k,v| [v, k]}
  end
end
