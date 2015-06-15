class EventsController < ApplicationController
  layout 'pages'
  
  def show
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = 'Event Create success!'
      redirect_to edit_event_url(id: @event.id) and return
    end
    flash[:error] = "We're sorry, we cannot create the event at the moment"
    render template: 'events/new'
  end
  
  def index
    @events = Event.all
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def destroy
    Event.find(params[:id]).destroy
    redirect_to events_url
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = 'Event Update success!'
      redirect_to edit_event_url and return
    end
    flash[:error] = "We're sorry, we cannot update the event at the moment"
    render template: 'events/edit'
  end
  
  # def sort
  #   Event.sort!(params[:event][:sort])
  #   flash[:success] = 'Event Sort success!'
  #   redirect_to events_url
  # end
  
  protected
    
    def event_params
      params.require(:event).permit!
    end
end
