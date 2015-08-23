module BannersHelper
  def banners(*args)
    active_banners = Banner.all.active.order(:sort)
    
    str = '<div id="carousel-home" class="carousel slide" data-ride="carousel">'
    str << indicator_str(active_banners.size)
    str << banner_items(active_banners)
    str << control_str  
    str << '</div>'
    
    raw(str)
  end

  protected
  
    def indicator_str(num)
      indicator_str = '<ol class="carousel-indicators">'
      0.upto(num-1).each do |i|
        indicator_str << '<li data-target="#carousel-home" data-slide-to="'
        indicator_str << i.to_s
        indicator_str << '"'
        indicator_str << ' class="active"' if i == 0
        indicator_str << '></li>'
      end
      indicator_str << '</ol>'
      indicator_str
    end
    
    def banner_items(banners)
      str = '<div class="carousel-inner">'
      banners.each_with_index do |banner, index|
        str << '<div class="item'
        str << ' active' if index == 0
        str << '">'
        str << image_tag(banner.image.url)
        str << '</div>'
      end
      str << '</div>'
      str
    end
    
    def control_str
      <<-STR
    		<!-- Controls -->
    		<a class="left carousel-control" href="#carousel-home" role="button" data-slide="prev">
    			<span class="glyphicon glyphicon-chevron-left ion-ios-arrow-thin-left"></span>
    		</a>
    		<a class="right carousel-control" href="#carousel-home" role="button" data-slide="next">
    			<span class="glyphicon glyphicon-chevron-right ion-ios-arrow-thin-right"></span>
    		</a>
      STR
    end
end
