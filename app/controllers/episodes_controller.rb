class EpisodesController < ApplicationController
  layout 'contents'

  def new
    @episode = Episode.new
  end
  
  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:success] = 'Episode Create success!'
      redirect_to edit_admin_contents_comic_episode_url(id: @episode.id) and return
    end
    @errors = @episode.errors
    flash[:error] = "We're sorry, we cannot create the episode at the moment"
    render template: 'episodes/new'
  end
  
  def index
    @episodes = Episode.all.order(:sort)
  end
  
  def edit
    @episode = Episode.find(params[:id])
  end
  
  def destroy
    Episode.find(params[:id]).destroy
    redirect_to admin_contents_comic_episodes_url
  end
  
  def update
    @episode = Episode.find(params[:id])
    if @episode.update_attributes(episode_params)
      flash[:success] = 'Episode Update success!'
      redirect_to edit_admin_contents_comic_episode_url and return
    end
    @errors = @episode.errors
    flash[:error] = "We're sorry, we cannot update the episode at the moment"
    render template: 'episodes/edit'
  end
  
  def sort
    Episode.sort!(params[:episode][:sort])
    flash[:success] = 'Episode Sort success!'
    redirect_to admin_contents_comic_episodes_url
  end
  
  protected
    
    def episode_params
      params.require(:episode).permit!
    end
end
