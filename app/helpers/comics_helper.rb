module ComicsHelper
  def comic_options
    Comic.all.order(:sort).collect {|c| [c.name, c.id]}
  end
  
  def comics(*args)
    options = default_options(args.first)
    
    case options[:mode]
    when 'all'
      all_comics(Comic.all.active, options)
    when 'comic'
      comic_episodes(options[:comic], options)
    when 'related'
      related_comics(options[:episode], options)
    else
      '' #Episode.all.active.limit(5)
    end
    
  end

  def all_comics(comics, options)
    str = ''
    comics.each_with_index do |comic, index|
      str << '<div class="clearfix visible-xs-block"></div>' if (index % 3) == 0
      str << '<div class="clearfix visible-md-block"></div>' if (index % 5) == 0
      str << '<div class="col-md-15 col-xs-4">'
      str << '<div class="comicBox">'
      str << comic_item(comic, options)
      str << '</div>'
      str << '</div>'
    end
    
    raw(str)
  end

  def comic_episodes(comic, options)
    str = ''
    comic.episodes.each_with_index do |episode, index|
      str << '<div class="row episode">'
      str << episode_item_url(episode, options)
      str << episode_item_title(episode, options)
      str << episode_item_likes(episode, options)
      str << episode_item_date(episode, options)
      str << '</div>'
			str << '<hr/>'
    end
    
    raw(str)
  end
  
  def related_comics(episode, options)
    str = ''
    episode.related_comics[0..4].each do |comic|
      str << '<div class="col-md-15 col-xs-12">'
      str << '<div class="comicBox">'
      str << comic_item(comic, options)
      str << '</div>'
      str << '</div>'
    end
    
    raw(str)
  end
  
  protected
  
    def comic_item(comic, options)
      img_str = comic_item_img(comic, options)
      str = link_to(raw(img_str), catalogs_comic_url(comic: comic.url_name), class: 'thumbLink')
      str << raw(comic_item_info(comic, options))
      str
    end
    
    def comic_item_img(comic, options)
      str = '<div class="thumb-overlay"></div>'
      str << image_tag(comic.episode_image.url, class: "img-responsive")
      str
    end
        
    def comic_item_info(comic, options)
      str = '<div class="infoText">'
  		str << '<div class="genre"><small>'
  		str << comic.category_name
  		str << '</small></div>'
  		comic_title = '<div class="comicTitle">'
  		comic_title << comic.name
  		comic_title << '</div>'
  		str << link_to(raw(comic_title), catalogs_comic_url(comic: comic.url_name))
  		str << '<div class="creatorName">Alex Irzaqi</div>'
  		str << '</div>'
  		str
    end
  
    def episode_item_url(episode, options)
      str = '<div class="col-xs-2">'
      img_str = episode_item_img(episode, options)
      str << link_to(raw(img_str), catalogs_comic_episode_url(episode: episode.url_name), class: 'thumbLink')
      str << '</div>'
    end
    
    def episode_item_title(episode, options)
      str = '<div class="col-xs-4">'
      title_str = '<div class="comicTitle">'
      title_str << episode.name
      title_str << '</div>'
      str << link_to(raw(title_str), catalogs_comic_episode_url(episode: episode.url_name))
      str << '</div>'
    end
    
    def episode_item_img(episode, options)
      str = '<div class="thumb-overlay"></div>'
      str << image_tag(episode.image.url, class: "img-responsive")
      str
    end

    def episode_item_likes(episode, options)
      str = '<div class="col-xs-4">'
			str << '<div class="comicLikes">'
			5.times do |i|
			  str << '<i class="fa fa-star'
			  str << '-o' if i >= episode.rating
			  str << '"></i>'
		  end
			str << '</div>'
			str << '</div>'
		end
		
    def episode_item_date(episode, options)
      str = '<div class="col-xs-2">'
			str << '<i class="comicDate">'
			str << '</i>'
			str << '</div>'
    end
    
end
