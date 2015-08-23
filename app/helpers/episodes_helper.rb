module EpisodesHelper
  def episodes(*args)
    options = default_options(args.first)
    
    episodes = case options[:mode]
                when 'popular'; Episode.all.active.popular.limit(5)
                when 'latest';  Episode.all.active.latest.limit(5)
                when 'premium'; Episode.all.active.premium.limit(4)
                else;           Episode.all.active.limit(5)
                end
    
    str = ''
    episodes.each do |episode|
      str << episode_item(episode, options)
    end
    
    raw(str)
  end
  
  
  protected
  
    def episode_item(episode, options)
      str = '<div class="'
      str << options[:class]
      str << '">'

      str << '<div class="comicBox">'
      str << link_to((image_tag(episode.image.url, class: "img-responsive img-hover") + episode.name), pages_episode_url(id: episode.url_name))
      
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
