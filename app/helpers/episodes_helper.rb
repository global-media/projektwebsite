module EpisodesHelper
  def episodes(*args)
    options = default_options(args.first)
    
    case options[:mode]
    when 'latest'
      latest_episodes(Episode.all.active.latest.limit(4), options)
    when 'popular'
      popular_episodes(Episode.all.active.popular.limit(5), options)
    when 'premium'
      premium_episodes(Episode.all.active.premium.limit(4), options)
    when 'reader'
      reader_episodes(options[:episode], options)
    else
      '' #Episode.all.active.limit(5)
    end
  end
  
  def latest_episodes(episodes, options)
    str = ''
    episodes.each do |episode|
      str << '<div class="col-md-6 col-sm-12">'
      str << '<div class="comicLatest">'
      str << episode_item(episode, options)
      str << '</div>'
      str << '</div>'
    end
    
    raw(str)
  end

  def popular_episodes(episodes, options)
    str = ''
    episodes.each do |episode|
      str << '<div class="col-md-15 col-xs-12">'
      str << '<div class="comicBox">'
      str << episode_item(episode, options)
      str << '</div>'
      str << '</div>'
    end
    
    raw(str)
  end

  def premium_episodes(episodes, options)
    str = ''
    episodes.each do |episode|
      str << episode_item(episode, options)
    end
    
    raw(str)
  end
  
  def reader_episodes(episode, options)
    str = '<div class="row">'
    str << '<div class="col-md-8 col-md-push-2 comic_episodeImgs">'
		str << '<ul id="lightgallery">'
		
		episode.images.order(:sort).each do |image|
  		str << '<li data-src="'
  		str << image.image.url
  		str << '">'
  		str << '<a href="">'
      str << image_tag(raw(image.image.url))
      str << '</a>'
  		str << '</li>'
		end
		
		str << '</ul>'
		str << '</div>'
		str << '</div>'
		
		raw(str)
  end
  
  protected
  
    def episode_item(episode, options)
      img_str = episode_item_img(episode, options)
      str = link_to(raw(img_str), catalogs_comic_episode_url(episode: episode.url_name), class: 'thumbLink')
      str << raw(episode_item_info(episode, options))
      str
    end
    
    def episode_item_img(episode, options)
      str = '<div class="thumb-overlay"></div>'
      image_url = case options[:mode]
                  when 'latest'
                    episode.banner_image.url
                  else
                    episode.image.url
                  end
      str << image_tag(image_url, class: "img-responsive")
      str
    end

    def episode_item_info(episode, options)
      str = '<div class="infoText">'
  		str << '<div class="genre"><small>'
  		str << episode.comic.category_name
  		str << '</small></div>'
  		comic_title = '<div class="comicTitle">'
  		comic_title << episode.comic.name
  		comic_title << '</div>'
  		str << link_to(raw(comic_title), catalogs_comic_episode_url(episode: episode.url_name))
  		str << '<div class="creatorName">Alex Irzaqi</div>'
  		str << '</div>'
  		str
    end
    
    def old_episode_item(episode, options)
      str = '<div class="'
      str << options[:class]
      str << '">'

      str << '<div class="comicBox">'
      str << link_to((image_tag(episode.image.url, class: "img-responsive img-hover") + episode.name), catalogs_comic_episode_url(episode: episode.url_name))
      
      str << '<div class="infoText">'
      str << '<div class="comicTitle">'
      str << episode.comic.name
      str << '</div>'
      
      str << '<div class="creatorName">'
      str << 'Creator Name' # TODO
      str << '</div>'
      
      if episode.comic.category
        str << '<div class="genre">'
        str << episode.comic.category.name
        str << '</div'
      end
      
      str << '</div>'
      <<-STR
          # <a href="/pages/comic">
          #   <img class="img-responsive img-hover" src="http://placehold.it/300x300" alt="">
          #   ep. #1
          # </a>
      		<div class="infoText">
      			<div class="comicTitle">Comic Title</div>
      			<div class="creatorName">Creator Name</div>
      			<div class="genre">Genre</div>
      		</div>
      STR
      str << '</div></div>'
      str
    end
end
