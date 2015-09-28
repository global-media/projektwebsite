class CatalogsController < ApplicationController
  layout 'pages'
  
  def comic
    @comic = Comic.find_by_url_name(params[:comic])
  end
  
  def episode
    @episode = Episode.find_by_url_name(params[:episode])
    render layout: 'episode'
  end
end
